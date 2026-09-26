window.REM_ADMISION = {

    areas: {
        mate: { nombre: "➗ Matemáticas", color: "var(--celeste)" },
        lectura: { nombre: "📖 Lectura Crítica", color: "var(--verde_apagado)" },
        ciencias: { nombre: "🔬 Ciencias Naturales", color: "var(--celeste_apagado)" },
        sociales: { nombre: "🏛️ Sociales y Ciudadanas", color: "var(--cian)" },
        ingles: { nombre: "🌐 Inglés", color: "var(--celeste_apagadito)" }
    },

    // estas son las 20 preguntas gratuitas. Las 50 de la versión Premium
    // ya no viven aquí: las entrega api/preguntas-premium.php solo a
    // quien haya pagado, para que no se puedan copiar desde el navegador.
    preguntas: [
        // ---------- MATEMÁTICAS ----------
        { id: "a01", area: "mate", texto: "¿Cuál es el resultado de 8 × 7 − 15?", opciones: ["41", "45", "56", "61"], respuesta: "41" },
        { id: "a02", area: "mate", texto: "Un producto cuesta $60.000 y tiene un descuento del 20%. ¿Cuánto se paga por él?", opciones: ["$40.000", "$45.000", "$48.000", "$52.000"], respuesta: "$48.000" },
        { id: "a03", area: "mate", texto: "¿Cuál es el siguiente número en la secuencia 2, 4, 8, 16, ___?", opciones: ["20", "24", "30", "32"], respuesta: "32" },
        { id: "a04", area: "mate", texto: "Un carro recorre 180 km en 3 horas. ¿Cuál es su velocidad promedio?", opciones: ["50 km/h", "60 km/h", "65 km/h", "70 km/h"], respuesta: "60 km/h" },

        // ---------- LECTURA CRÍTICA ----------
        { id: "a11", area: "lectura", texto: "\"La biblioteca pública amplió su horario los fines de semana debido a la alta demanda de estudiantes que buscan un espacio tranquilo para estudiar.\" ¿Cuál es la idea principal?", opciones: ["La biblioteca cerrará los fines de semana", "La biblioteca amplió su horario por la demanda de estudiantes", "Los estudiantes prefieren estudiar en casa", "La biblioteca solo atiende entre semana"], respuesta: "La biblioteca amplió su horario por la demanda de estudiantes" },
        { id: "a12", area: "lectura", texto: "¿Cuál palabra es sinónimo de \"perseverante\"?", opciones: ["Indeciso", "Constante", "Distraído", "Apático"], respuesta: "Constante" },
        { id: "a13", area: "lectura", texto: "\"Aunque el proyecto tenía un presupuesto limitado, el equipo logró terminarlo a tiempo.\" ¿Qué relación expresa la palabra \"Aunque\"?", opciones: ["Causa", "Consecuencia", "Contraste", "Condición"], respuesta: "Contraste" },
        { id: "a14", area: "lectura", texto: "\"Únicamente los estudiantes que se inscribieron antes del 15 de marzo recibieron un descuento.\" ¿Qué se puede concluir de un estudiante que se inscribió el 20 de marzo?", opciones: ["Recibió el descuento completo", "No recibió el descuento", "Recibió un descuento mayor", "El texto no lo menciona"], respuesta: "No recibió el descuento" },

        // ---------- CIENCIAS NATURALES ----------
        { id: "a21", area: "ciencias", texto: "¿Cuál es el órgano encargado de bombear la sangre por el cuerpo?", opciones: ["Pulmón", "Corazón", "Hígado", "Riñón"], respuesta: "Corazón" },
        { id: "a22", area: "ciencias", texto: "¿Qué gas necesitan las plantas para realizar la fotosíntesis?", opciones: ["Oxígeno", "Nitrógeno", "Dióxido de carbono", "Hidrógeno"], respuesta: "Dióxido de carbono" },
        { id: "a23", area: "ciencias", texto: "¿Cuál es el estado del agua a 0°C bajo presión atmosférica normal?", opciones: ["Líquido", "Sólido", "Gaseoso", "Plasma"], respuesta: "Sólido" },
        { id: "a24", area: "ciencias", texto: "¿Cuál de las siguientes es una fuente de energía renovable?", opciones: ["Carbón", "Petróleo", "Energía solar", "Gas natural"], respuesta: "Energía solar" },

        // ---------- SOCIALES Y CIUDADANAS ----------
        { id: "a31", area: "sociales", texto: "¿Cómo se le llama al conjunto de normas que rigen la convivencia en un país y son de obligatorio cumplimiento?", opciones: ["Costumbres", "Leyes", "Tradiciones", "Creencias"], respuesta: "Leyes" },
        { id: "a32", area: "sociales", texto: "¿Cuál es la función principal del voto en una democracia?", opciones: ["Elegir representantes", "Pagar impuestos", "Declarar la guerra", "Firmar tratados"], respuesta: "Elegir representantes" },
        { id: "a33", area: "sociales", texto: "¿Cómo se denomina la división de poderes en ejecutivo, legislativo y judicial?", opciones: ["Federalismo", "Separación de poderes", "Centralismo", "Monarquía"], respuesta: "Separación de poderes" },
        { id: "a34", area: "sociales", texto: "¿Cuál de los siguientes es un derecho fundamental reconocido en la mayoría de las constituciones?", opciones: ["El derecho a la vida", "El derecho a no pagar impuestos", "El derecho a no trabajar", "El derecho a no estudiar"], respuesta: "El derecho a la vida" },

        // ---------- INGLÉS ----------
        { id: "a41", area: "ingles", texto: "Choose the correct option: \"She ___ a student.\"", opciones: ["is", "are", "am", "be"], respuesta: "is" },
        { id: "a42", area: "ingles", texto: "What is the synonym of \"happy\"?", opciones: ["Sad", "Angry", "Glad", "Tired"], respuesta: "Glad" },
        { id: "a43", area: "ingles", texto: "Complete: \"They ___ to school every day.\"", opciones: ["go", "goes", "going", "went"], respuesta: "go" },
        { id: "a44", area: "ingles", texto: "Choose the correct question word: \"___ is your name?\"", opciones: ["Where", "What", "When", "Why"], respuesta: "What" }
    ]
};
