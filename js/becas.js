document.addEventListener("DOMContentLoaded", function () {
    const carrusel = document.querySelector(".carrusel_becas");
    if (!carrusel) return;

    const ventana = carrusel.querySelector(".ventana_becas");
    const tarjetas = Array.from(carrusel.querySelectorAll(".tarjeta_beca"));
    const anterior = carrusel.querySelector(".flecha_anterior");
    const siguiente = carrusel.querySelector(".flecha_siguiente");
    const contenedorPuntos = document.querySelector(".puntos_becas");
    const sinMovimiento = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

    const PAUSA_MS = 4500;
    let porVista = 4;
    let indice = 0;
    let temporizador = null;
    let enPausa = false;

    function tarjetasPorVista() {
        if (window.innerWidth >= 1400) return 4;
        if (window.innerWidth >= 1000) return 3;
        if (window.innerWidth >= 700) return 2;
        return 1;
    }

    function posiciones() {
        return Math.max(tarjetas.length - porVista + 1, 1);
    }

    function pintarPuntos() {
        contenedorPuntos.innerHTML = "";
        for (let i = 0; i < posiciones(); i++) {
            const punto = document.createElement("button");
            punto.type = "button";
            punto.className = "punto_beca";
            punto.setAttribute("aria-label", `Ir al grupo de becas ${i + 1}`);
            punto.addEventListener("click", () => {
                irA(i);
                reiniciar();
            });
            contenedorPuntos.appendChild(punto);
        }
    }

    function actualizar() {
        carrusel.style.setProperty("--por_vista", porVista);
        carrusel.style.setProperty("--indice", indice);

        contenedorPuntos.querySelectorAll(".punto_beca").forEach((punto, i) => {
            punto.setAttribute("aria-current", i === indice ? "true" : "false");
        });

        tarjetas.forEach((tarjeta, i) => {
            tarjeta.inert = i < indice || i >= indice + porVista;
        });
    }

    function irA(destino) {
        const total = posiciones();
        indice = ((destino % total) + total) % total;
        actualizar();
    }

    function avanzar() {
        irA(indice + 1);
    }

    function retroceder() {
        irA(indice - 1);
    }

    function detener() {
        clearInterval(temporizador);
        temporizador = null;
    }

    function iniciar() {
        if (sinMovimiento || enPausa || temporizador) return;
        temporizador = setInterval(avanzar, PAUSA_MS);
    }

    function reiniciar() {
        detener();
        iniciar();
    }

    function pausar() {
        enPausa = true;
        detener();
    }

    function reanudar() {
        enPausa = false;
        iniciar();
    }

    function recalcular() {
        const nuevo = tarjetasPorVista();
        if (nuevo === porVista && contenedorPuntos.children.length) return;
        porVista = nuevo;
        indice = Math.min(indice, posiciones() - 1);
        pintarPuntos();
        actualizar();
    }

    anterior.addEventListener("click", () => {
        retroceder();
        reiniciar();
    });

    siguiente.addEventListener("click", () => {
        avanzar();
        reiniciar();
    });

    carrusel.addEventListener("mouseenter", pausar);
    carrusel.addEventListener("mouseleave", reanudar);
    carrusel.addEventListener("focusin", pausar);
    carrusel.addEventListener("focusout", reanudar);

    let inicioX = null;

    ventana.addEventListener("pointerdown", evento => {
        inicioX = evento.clientX;
    });

    ventana.addEventListener("pointerup", evento => {
        if (inicioX === null) return;
        const diferencia = evento.clientX - inicioX;
        inicioX = null;
        if (Math.abs(diferencia) < 50) return;
        if (diferencia < 0) avanzar();
        else retroceder();
        reiniciar();
    });

    ventana.addEventListener("pointercancel", () => {
        inicioX = null;
    });

    document.addEventListener("visibilitychange", () => {
        if (document.hidden) detener();
        else iniciar();
    });

    window.addEventListener("resize", recalcular);

    recalcular();
    iniciar();
});
