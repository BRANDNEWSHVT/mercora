---
description: "Explain code with analogies, diagrams, and step-by-step walkthrough."
---

# /explain — Code Explanation

Explain code in a clear, educational way.

## Instructions

1. **Read the target** from `$ARGUMENTS`:
   - Full file or specific function/class
   - Understand ALL the code before explaining any of it

2. **Structure the explanation**:

   ### 🎯 One-Sentence Summary
   What does this code do in plain English?

   ### 🔗 Analogy
   Compare it to something from everyday life. E.g.: "This function is like a post office — it receives packages (requests), sorts them by destination (routes), and hands them to the right delivery truck (handler)."

   ### 📊 Diagram
   Draw an ASCII diagram showing the flow:
   ```
   Input → [Validate] → [Transform] → [Store] → Output
              ↓                           ↓
           [Error]                    [Notify]
   ```

   ### 🚶 Step-by-Step Walkthrough
   Walk through the code line by line:
   1. First, we... (line X)
   2. Then... (line Y)
   3. Finally... (line Z)

   ### ⚠️ Gotcha
   What's a common mistake or misconception about this code?

   ### 🔗 Related Code
   What other files/functions does this interact with?

3. **Keep it conversational** — explain like you're teaching a friend.
4. **Highlight the WHY** — not just what the code does, but why it's written this way.
