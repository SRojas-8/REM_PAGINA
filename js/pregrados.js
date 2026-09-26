document.addEventListener("DOMContentLoaded", async function () {
    const zona = $("zona_universidades");

    try {
        const resultado = await pedirApi("universidades.php");

        if (!resultado.exito || !resultado.universidades.length) {
            throw new Error("sin universidades");
        }

        zona.innerHTML = resultado.universidades.map(u => `
            <div class="card">
                <div class="logo-card">
                    <img src="img/imgpregrados/Unis/${u.escudo}" alt="escudo ${limpiar(u.nombre)}">
                </div>
                <div class="info">
                    <h2>Conoce la oferta académica en pregrados de la ${limpiar(u.nombre)}</h2>
                    <a href="${u.url_oferta}" target="_blank" rel="noopener">Leer más...</a>
                </div>
            </div>
        `).join("");
    } catch (e) {
        zona.innerHTML = '<p class="cargando_universidades">No pudimos cargar las universidades en este momento. Intenta de nuevo más tarde.</p>';
    }
});
