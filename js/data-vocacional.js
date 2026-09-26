window.REM_VOCACIONAL = {

    areas: {
        stem: {
            nombre: "⚙️ Ciencias Exactas e Ingeniería",
            color: "var(--celeste)",
            texto: "Te atrae entender cómo funcionan las cosas, resolver problemas con lógica y crear soluciones técnicas. Disfrutas los retos que se resuelven paso a paso.",
            carreras: ["Ingeniería de Software", "Ingeniería Civil", "Ingeniería Aeronáutica", "Ingeniería Industrial", "Arquitectura", "Ingeniería Mecánica"]
        },
        salud: {
            nombre: "🩺 Ciencias de la Salud",
            color: "var(--verde_apagado)",
            texto: "Disfrutas cuidar y ayudar a otras personas. Te interesa entender el cuerpo humano, el bienestar y acompañar procesos de recuperación.",
            carreras: ["Medicina", "Enfermería", "Odontología", "Psicología", "Fisioterapia", "Bacteriología"]
        },
        social: {
            nombre: "🌍 Ciencias Sociales y Humanas",
            color: "var(--celeste_apagado)",
            texto: "Te interesa comprender a las personas, la sociedad y la cultura. Te gustaría generar impacto social y acompañar a otros con tus ideas.",
            carreras: ["Derecho", "Ciencias Políticas", "Trabajo Social", "Comunicación Social", "Educación", "Sociología"]
        },
        arte: {
            nombre: "🎨 Artes y Comunicación",
            color: "var(--cian)",
            texto: "Tienes una mente creativa: disfrutas imaginar, diseñar y contar historias en distintos formatos y medios.",
            carreras: ["Diseño Gráfico", "Comunicación Audiovisual", "Publicidad", "Cine y Televisión", "Artes Plásticas"]
        },
        negocios: {
            nombre: "💼 Administración y Negocios",
            color: "var(--celeste_apagadito)",
            texto: "Tienes visión estratégica: te gusta liderar equipos, organizar recursos y tomar decisiones para alcanzar objetivos.",
            carreras: ["Administración de Empresas", "Negocios Internacionales", "Mercadeo", "Finanzas", "Economía", "Contaduría Pública"]
        }
    },

    // estas son las 20 afirmaciones gratuitas. Las 50 de la versión
    // Premium ya no viven aquí: las entrega api/preguntas-premium.php
    // solo a quien haya pagado.
    preguntas: [
        // ---------- STEM ----------
        { id: "v01", area: "stem", texto: "Disfruto resolver problemas de matemáticas o de lógica." },
        { id: "v02", area: "stem", texto: "Me llama la atención entender cómo funcionan las máquinas o los aparatos electrónicos." },
        { id: "v03", area: "stem", texto: "Se me facilita identificar patrones al analizar datos o información." },
        { id: "v04", area: "stem", texto: "Me gustaría diseñar o construir estructuras, puentes o edificios." },

        // ---------- SALUD ----------
        { id: "v11", area: "salud", texto: "Me interesa saber cómo funciona el cuerpo humano." },
        { id: "v12", area: "salud", texto: "Disfruto ayudar a otras personas cuando se sienten mal o están enfermas." },
        { id: "v13", area: "salud", texto: "Me gustaría trabajar en un hospital, una clínica o un centro de salud." },
        { id: "v14", area: "salud", texto: "Soy una persona paciente y tranquila en situaciones de estrés o urgencia." },

        // ---------- SOCIAL ----------
        { id: "v21", area: "social", texto: "Me interesa entender por qué las personas piensan y actúan de cierta manera." },
        { id: "v22", area: "social", texto: "Disfruto leer sobre historia, política o cultura de otros países." },
        { id: "v23", area: "social", texto: "Me gustaría trabajar en proyectos que ayuden a mejorar mi comunidad." },
        { id: "v24", area: "social", texto: "Me considero una persona empática, que escucha bien a los demás." },

        // ---------- ARTE ----------
        { id: "v31", area: "arte", texto: "Disfruto actividades creativas como dibujar, diseñar o crear contenido." },
        { id: "v32", area: "arte", texto: "Me gusta expresar ideas a través de imágenes, videos o sonidos." },
        { id: "v33", area: "arte", texto: "Se me facilita imaginar cómo se vería algo antes de crearlo." },
        { id: "v34", area: "arte", texto: "Disfruto contar historias, ya sea escribiendo, hablando o grabando." },

        // ---------- NEGOCIOS ----------
        { id: "v41", area: "negocios", texto: "Me gustaría liderar o coordinar un equipo de trabajo." },
        { id: "v42", area: "negocios", texto: "Me interesa saber cómo se crea y se administra una empresa." },
        { id: "v43", area: "negocios", texto: "Disfruto organizar tareas, tiempos y recursos para lograr un objetivo." },
        { id: "v44", area: "negocios", texto: "Me llama la atención el mundo de las finanzas, la inversión o los negocios." }
    ]
};
