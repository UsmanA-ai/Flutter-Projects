/// <reference types="https://esm.sh/@supabase/functions-js/edge-runtime.d.ts" />
import { serve } from "https://deno.land/std@0.168.0/http/server.ts"

const GROQ_API_KEY = Deno.env.get("GROQ_API_KEY")

serve(async (req: Request) => {
  // Handle CORS
  if (req.method === 'OPTIONS') {
    return new Response('ok', { 
      headers: { 
        "Access-Control-Allow-Origin": "*", 
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "POST" 
      } 
    })
  }

  try {
    const { result, type } = await req.json()

    const response = await fetch("https://api.groq.com/openai/v1/chat/completions", {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${GROQ_API_KEY}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        model: "llama-3.1-8b-instant",
        messages: [
          { 
            role: "system", 
            content: `You are a medical assistant. Explain this ${type} result in 2-3 simple sentences for a patient. Be empathetic and professional. Mention that they should consult a doctor for a full clinical diagnosis.` 
          },
          { 
            role: "user", 
            content: `Result: ${result}` 
          }
        ],
        temperature: 0.7,
      }),
    })

    const data = await response.json()
    return new Response(JSON.stringify(data), {
      headers: { 
        "Content-Type": "application/json", 
        "Access-Control-Allow-Origin": "*" 
      },
    })
  } catch (error: any) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { 
        "Content-Type": "application/json", 
        "Access-Control-Allow-Origin": "*" 
      },
    })
  }
})
