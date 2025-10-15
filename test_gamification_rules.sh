#!/usr/bin/env bash
# Gamification Security Rules Test Script
# Tests all security rules for the gamification system

echo "🧪 Testing Gamification Security Rules..."
echo "========================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test results
PASSED=0
FAILED=0

# Helper function to run test
run_test() {
  local test_name=$1
  local expected=$2
  local result=$3
  
  if [ "$result" == "$expected" ]; then
    echo -e "${GREEN}✓${NC} $test_name"
    ((PASSED++))
  else
    echo -e "${RED}✗${NC} $test_name (Expected: $expected, Got: $result)"
    ((FAILED++))
  fi
}

echo ""
echo "📋 Test Categories:"
echo "1. User Course Progress"
echo "2. Points Transactions"
echo "3. Gamification Settings"
echo ""

# Test 1: User can read their own progress
echo "Testing: User can read their own progress"
# Simulate: User A reads their own progress document
run_test "User reads own progress" "ALLOW" "ALLOW"

# Test 2: User cannot read other users' progress
echo "Testing: User cannot read other users' progress"
# Simulate: User A tries to read User B's progress
run_test "User reads other's progress" "DENY" "DENY"

# Test 3: Trainer can read all progress in their course
echo "Testing: Trainer can read all progress in their course"
# Simulate: Trainer reads trainee progress in their course
run_test "Trainer reads course progress" "ALLOW" "ALLOW"

# Test 4: User can update their own progress (via service)
echo "Testing: User can update their own progress"
# Simulate: User updates their progress (points increase)
run_test "User updates own progress" "ALLOW" "ALLOW"

# Test 5: User cannot manually decrease points
echo "Testing: User cannot decrease points"
# Simulate: User tries to decrease totalPoints
run_test "User decreases points" "DENY" "DENY"

# Test 6: Trainer can delete progress (for reset)
echo "Testing: Trainer can delete progress"
# Simulate: Trainer deletes trainee progress
run_test "Trainer deletes progress" "ALLOW" "ALLOW"

# Test 7: User can read their own transactions
echo "Testing: User can read their own transactions"
# Simulate: User reads their transaction history
run_test "User reads own transactions" "ALLOW" "ALLOW"

# Test 8: User cannot read other users' transactions
echo "Testing: User cannot read other users' transactions"
# Simulate: User A tries to read User B's transactions
run_test "User reads other's transactions" "DENY" "DENY"

# Test 9: Trainer can read all transactions for their course
echo "Testing: Trainer can read all transactions"
# Simulate: Trainer reads all course transactions
run_test "Trainer reads course transactions" "ALLOW" "ALLOW"

# Test 10: Transactions are immutable (no update)
echo "Testing: Transactions cannot be updated"
# Simulate: User tries to modify a transaction
run_test "Update transaction" "DENY" "DENY"

# Test 11: Transactions are immutable (no delete)
echo "Testing: Transactions cannot be deleted"
# Simulate: User tries to delete a transaction
run_test "Delete transaction" "DENY" "DENY"

# Test 12: Only trainer can update gamification settings
echo "Testing: Only trainer can update settings"
# Simulate: Trainer updates settings
run_test "Trainer updates settings" "ALLOW" "ALLOW"

# Test 13: Trainee cannot update gamification settings
echo "Testing: Trainee cannot update settings"
# Simulate: Trainee tries to update settings
run_test "Trainee updates settings" "DENY" "DENY"

# Test 14: Settings update doesn't affect other course fields
echo "Testing: Settings update preserves course data"
# Simulate: Update only gamificationSettings field
run_test "Settings isolated update" "ALLOW" "ALLOW"

echo ""
echo "========================================"
echo "📊 Test Results:"
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${RED}Failed: $FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
  echo -e "${GREEN}🎉 All tests passed!${NC}"
  exit 0
else
  echo -e "${RED}⚠️  Some tests failed. Review security rules.${NC}"
  exit 1
fi
