// Define the shape of the incoming request body
interface RequestBody {
  userIds: string[];
  title?: string;
  content?: string;
  data?: Record<string, any>;
}
export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    // Handle CORS preflight requests for security
    if (request.method === 'OPTIONS') {
      return handleOptions(request);
    }

    // Only allow POST requests
    if (request.method !== 'POST') {
      return new Response('Method Not Allowed', { status: 405 });
    }

    // Get the body from the request sent by the Flutter app
    let body;
    try {
      body = await request.json() as RequestBody;
    } catch (e) {
      return new Response('Invalid JSON body', { status: 400 });
    }

    // Extract data sent from the Flutter app
    const { userIds, title, content, data } = body;

    if (!userIds || !Array.isArray(userIds) || userIds.length === 0) {
      return new Response('`userIds` is a required array.', { status: 400 });
    }

    const debug = request.headers.get('x-debug') === '1' || new URL(request.url).searchParams.get('debug') === '1';

    // Construct the payload for the OneSignal API
    const oneSignalPayload: Record<string, any> = {
      app_id: env.ONE_SIGNAL_APP_ID,
      include_external_user_ids: userIds,
      channel_for_external_user_ids: 'push',
      headings: { en: title || 'New Notification' },
      contents: { en: content || 'You have a new message.' },
      data: data || {},
    };

    // Basic validation & guardrails
    if (!env.ONE_SIGNAL_APP_ID || !env.ONE_SIGNAL_API_KEY) {
      return jsonResp({
        success: false,
        error: 'Missing ONE_SIGNAL_APP_ID or ONE_SIGNAL_API_KEY in environment',
      }, 500, debug);
    }
    if (userIds.length > 2000) {
      return jsonResp({
        success: false,
        error: 'Too many userIds (max 2000 for include_external_user_ids).',
        count: userIds.length,
      }, 400, debug);
    }

    let response: Response | null = null;
    let responseData: any = null;
    try {
      response = await fetch('https://api.onesignal.com/notifications', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': `Basic ${env.ONE_SIGNAL_API_KEY}`,
        },
        body: JSON.stringify(oneSignalPayload),
      });
      const text = await response.text();
      try {
        responseData = text ? JSON.parse(text) : {};
      } catch { responseData = { raw: text }; }
    } catch (e: any) {
      return jsonResp({
        success: false,
        error: 'Network/Fetch error',
        details: e?.message || String(e),
        request: debug ? oneSignalPayload : undefined,
      }, 502, debug);
    }

    const ok = response!.ok && responseData?.id;
    const status = response!.status;
    if (!ok) {
      return jsonResp({
        success: false,
        status,
        onesignalResponse: responseData,
        request: debug ? oneSignalPayload : undefined,
      }, status >= 400 ? status : 500, debug);
    }
    return jsonResp({
      success: true,
      status,
      onesignalResponse: responseData,
      recipients: responseData?.recipients,
      request: debug ? oneSignalPayload : undefined,
    }, 200, debug);
  },
};

// Helper function to handle CORS
function handleOptions(request: Request) {
  let headers = request.headers;
  if (
    headers.get('Origin') !== null &&
    headers.get('Access-Control-Request-Method') !== null &&
    headers.get('Access-Control-Request-Headers') !== null
  ) {
    return new Response(null, {
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type',
      },
    });
  } else {
    return new Response(null, {
      headers: {
        Allow: 'POST, OPTIONS',
      },
    });
  }
}

// Define the shape of our environment variables (secrets)
interface Env {
    ONE_SIGNAL_APP_ID: string;
    ONE_SIGNAL_API_KEY: string;
}

function jsonResp(obj: any, status = 200, debug = false): Response {
  const base = {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
  };
  if (debug) {
    // Expose minimal extra header for debugging
    (base as any)['X-Debug'] = '1';
  }
  return new Response(JSON.stringify(obj), { status, headers: base });
}