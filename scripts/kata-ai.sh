#!/bin/bash

LEVEL=$1
NAME=$2

if [ -z "$LEVEL" ] || [ -z "$NAME" ]; then
  echo "Usage: kata-ai <level> <kata-name>"
  exit 1
fi

BASE_DIR="$LEVEL/$NAME"
DATE=$(date +%F)

echo "🚀 Creating Codewars Pro Kata: $BASE_DIR"

mkdir -p "$BASE_DIR"

# Normalize title
TITLE=$(echo "$NAME" | sed -r 's/-/ /g' | sed -r 's/\b(.)/\U\1/g')
METHOD=$(echo "$NAME" | sed 's/-//g')

# Smart inference engine (better rules)
RETURN_TYPE="int"
PARAMS="int number"

if [[ "$NAME" == *"string"* || "$NAME" == *"uppercase"* || "$NAME" == *"lowercase"* ]]; then
  RETURN_TYPE="String"
  PARAMS="String str"
elif [[ "$NAME" == *"even"* || "$NAME" == *"odd"* || "$NAME" == *"valid"* ]]; then
  RETURN_TYPE="boolean"
  PARAMS="int number"
fi

# -------------------------
# JAVA SOLUTION FILE
# -------------------------
cat > "$BASE_DIR/Solution.java" <<EOF
public class Kata {
    public static $RETURN_TYPE $METHOD($PARAMS) {
        // TODO: implement
        return ${RETURN_TYPE/default};
    }
}
EOF

# -------------------------
# README (CODEWARS STYLE)
# -------------------------
cat > "$BASE_DIR/README.md" <<EOF
# $TITLE

**Rank:** $LEVEL  
**Language:** Java  
**Completed:** $DATE  

---

## Problem
Auto-generated Codewars template.

---

## Solution

\`\`\`java
public class Kata {
    public static $RETURN_TYPE $METHOD($PARAMS) {
        // TODO: implement
        return ${RETURN_TYPE/default};
    }
}
\`\`\`
EOF

# -------------------------
# JUNIT TEST FILE
# -------------------------
mkdir -p "$BASE_DIR/test"

cat > "$BASE_DIR/test/KataTest.java" <<EOF
import org.junit.Test;
import static org.junit.Assert.*;

public class KataTest {

    @Test
    public void sampleTest() {
        // TODO: add real tests
        assertTrue(true);
    }
}
EOF

# -------------------------
# VS CODE OPEN
# -------------------------
if command -v code &> /dev/null; then
  code "$BASE_DIR"
fi

# -------------------------
# GIT SAFETY FLOW
# -------------------------
git add "$BASE_DIR"

if git diff --cached --quiet; then
  echo "⚠️ Nothing to commit"
else
  git commit -m "Add $LEVEL $TITLE (Codewars Pro AI)"
  git push origin main
fi

echo "✅ Codewars Pro Kata created successfully!"
