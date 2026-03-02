<%@ Page Title="Futuro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Prueba.future" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- 1. EL CONTENEDOR DEL FONDO FUTURISTA -->
    <div id="futuristic-bg"></div>

    <!-- 2. TU CONTENIDO (Flotando sobre el fondo) -->
    <div class="container content-overlay">
        <h1 class="display-4 fw-bold text-white mb-3">El Futuro de PAVECA</h1>
        <p class="lead text-white-50 mb-5">Innovación, tecnología y redes de distribución interconectadas en constante movimiento.</p>
        
        <div class="row g-4">
            <div class="col-md-6">
                <div class="glass-card">
                    <h3>Red de Distribución</h3>
                    <p>Nuestros nodos logísticos se conectan entre si para optimizar las entregas a nivel nacional, adaptándose dinámicamente a la demanda.</p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="glass-card">
                    <h3>Análisis de Datos</h3>
                    <p>Procesamos miles de variables simultáneas para garantizar la calidad en cada bobina de papel, utilizando algoritmos de vanguardia.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- 3. LIBRERÍA NECESARIA (Solo ECharts normal) -->
    <script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>

    <!-- 4. SCRIPT DE ANIMACIÓN CONSTANTE -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {

            // Aplica el fondo oscuro definido en tu CSS
            document.body.classList.add('page-futuro');

            // Inicializar ECharts en el div del fondo
            var chartDom = document.getElementById('futuristic-bg');
            var myChart = echarts.init(chartDom);

            // ==========================================
            // [MODIFICABLE] 1. CONFIGURACIÓN PRINCIPAL
            // ==========================================
            // Cantidad de puntos en la pantalla. (Más de 200 puede poner lenta la PC de algunos usuarios)
            var nodeCount = 120;

            // Distancia en píxeles para que dos puntos se conecten con una línea.
            // Si lo subes a 300, habrá una telaraña gigante. Si lo bajas a 50, casi no habrá líneas.
            var maxDistance = 250;

            // 2. Crear Nodos Aleatorios
            var nodes = [];
            for (var i = 0; i < nodeCount; i++) {
                nodes.push({
                    id: i.toString(),

                    // Posición inicial aleatoria (X, Y)
                    value: [Math.random() * window.innerWidth, Math.random() * window.innerHeight],

                    // [MODIFICABLE] Tamaño del punto. 
                    // Math.random() * 3 + 5 significa: "Un tamaño aleatorio entre 5 y 8 píxeles"
                    symbolSize: Math.random() * 3 + 5,

                    itemStyle: {
                        // [MODIFICABLE] Color de los puntos. 
                        // Formato rgba(Rojo, Verde, Azul, Transparencia). 
                        // Cámbialo a 'rgba(0, 120, 83, 0.8)' para que sean Verde PAVECA.
                        color: 'rgba(0, 120, 83, 0.8)'
                    },

                    // [MODIFICABLE] Velocidad de movimiento.
                    // El 1.5 al final es el multiplicador. Si pones 0.5 irán muy lento. Si pones 5.0 irán rapidísimo.
                    vx: (Math.random() - 0.5) * 1.5,
                    vy: (Math.random() - 0.5) * 1.5
                });
            }

            // 3. Configuración inicial de ECharts
            var option = {
                backgroundColor: 'transparent',
                // Ejes invisibles (Requeridos por ECharts para saber el tamaño del lienzo)
                xAxis: { type: 'value', show: false, min: 0, max: window.innerWidth },
                yAxis: { type: 'value', show: false, min: 0, max: window.innerHeight },
                series: [{
                    type: 'graph',
                    layout: 'none',
                    coordinateSystem: 'cartesian2d',
                    symbol: 'circle',
                    data: nodes,
                    edges: [],
                    lineStyle: {
                        // [MODIFICABLE] Color y grosor de las líneas
                        color: 'rgba(255, 255, 255, 0.2)', // Blanco muy transparente
                        width: 1, // Grosor de la línea en píxeles
                        curveness: 0 // Si pones 0.2, las líneas serán curvas en lugar de rectas
                    },
                    animation: false // Apagado porque nosotros animaremos manualmente
                }]
            };

            myChart.setOption(option);

            // ==========================================
            // 4. EL MOTOR DE MOVIMIENTO CONSTANTE
            // ==========================================
            // setInterval ejecuta esta función repetidamente
            // [MODIFICABLE] El número 40 al final son los milisegundos. 
            // 40ms = 25 FPS. Si pones 16, irá a 60 FPS (más fluido pero consume más procesador).
            setInterval(function () {
                var edges = [];

                // Recorremos todos los puntos para moverlos
                for (var i = 0; i < nodes.length; i++) {
                    var node = nodes[i];

                    // Sumamos la velocidad a la posición actual
                    node.value[0] += node.vx; // Eje X
                    node.value[1] += node.vy; // Eje Y

                    // Lógica de rebote: Si toca el borde izquierdo (<=0) o derecho (>=ancho), invierte la velocidad X
                    if (node.value[0] <= 0 || node.value[0] >= window.innerWidth) node.vx *= -1;
                    // Lógica de rebote: Si toca arriba o abajo, invierte la velocidad Y
                    if (node.value[1] <= 0 || node.value[1] >= window.innerHeight) node.vy *= -1;

                    // Calcular distancias con los demás puntos para saber si dibujamos línea
                    for (var j = i + 1; j < nodes.length; j++) {
                        var nodeB = nodes[j];
                        var dx = node.value[0] - nodeB.value[0];
                        var dy = node.value[1] - nodeB.value[1];

                        // Teorema de Pitágoras para calcular la distancia real entre los dos puntos
                        var distance = Math.sqrt(dx * dx + dy * dy);

                        // Si la distancia es menor al límite que configuramos arriba (150px)...
                        if (distance < maxDistance) {

                            // Calculamos la transparencia. 
                            // Si están muy cerca (distancia casi 0), opacity será casi 1 (muy visible).
                            // Si están casi a 150px, opacity será casi 0 (casi invisible).
                            var opacity = 1 - (distance / maxDistance);

                            // Creamos la línea
                            edges.push({
                                source: node.id,
                                target: nodeB.id,
                                lineStyle: {
                                    // [MODIFICABLE] El 0.4 es la opacidad máxima. 
                                    // Si quieres que las líneas brillen mucho cuando se cruzan, ponlo en 1.0
                                    opacity: opacity * 0.5
                                }
                            });
                        }
                    }
                }

                // Le enviamos la nueva información a ECharts para que redibuje la pantalla
                myChart.setOption({
                    series: [{
                        data: nodes,
                        edges: edges
                    }]
                });

            }, 40); // <-- [MODIFICABLE] Velocidad de refresco (Milisegundos)

            // Adaptar el gráfico si el usuario cambia el tamaño de la ventana del navegador
            window.addEventListener('resize', function () {
                myChart.resize();
                myChart.setOption({
                    xAxis: { max: window.innerWidth },
                    yAxis: { max: window.innerHeight }
                });
            });

            // Limpiar la clase del body si el usuario navega a otra página
            window.addEventListener('beforeunload', function () {
                document.body.classList.remove('page-futuro');
            });
        });
    </script>
</asp:Content>