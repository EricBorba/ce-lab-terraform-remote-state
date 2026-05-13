#!/bin/bash
 
echo "Testing state locking..."
echo ""
echo "Step 1: Start terraform apply in background (don't auto-approve)"
terraform apply &
FIRST_PID=$!
 
sleep 3
 
echo ""
echo "Step 2: Try to run another terraform apply"
echo "This should fail with a lock error"
terraform plan
 
echo ""
echo "Step 3: Kill first process"
kill $FIRST_PID
 
echo ""
echo "Step 4: Verify lock is released"
terraform plan