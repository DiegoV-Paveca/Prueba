<%@ Page Title="Kanvan" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Kanvan.aspx.cs" Inherits="Prueba.Kanvan" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <!-- Cargar Tailwind CSS y fuente Inter (Es vital para que funcione el diseño) -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet" />

    <style>
        /* --- CLASES PARA ANIMACIONES FLUIDAS --- */
        .smooth-transition {
            transition: all 0.6s cubic-bezier(0.4, 0, 0.2, 1);
        }

        /* Transición específica para el gráfico circular */
        .progress-circle {
            transition: stroke-dashoffset 0.8s ease-in-out, stroke 0.6s ease;
            transform: rotate(-90deg);
            transform-origin: 50% 50%;
        }

        /* Números tabulares para evitar saltos de ancho visuales */
        .number-ticker {
            font-variant-numeric: tabular-nums;
        }

        /* Clase para el fondo general del Kanban */
        .kanban-font {
            font-family: "Inter", sans-serif;
        }
    </style>

    <!-- Recuadro principal con el estilo solicitado (Borde superior verde PAVECA) -->
    <div class="bg-gray-100 mx-auto shadow-sm my-5 kanban-font" style="max-width:1200px; border-radius:8px; border-top: 5px solid #007853; overflow: hidden;">

        <!-- ESTE DIV REEMPLAZA AL ANTIGUO <body> -->
        <div class="p-6 min-h-screen flex flex-col gap-6">

            <!-- HEADER -->
            <header class="flex flex-col md:flex-row justify-between items-center bg-white p-4 rounded-xl shadow-sm mb-2 gap-4">
                <div class="flex items-center gap-4 w-full md:w-auto">
                    <div class="bg-indigo-600 text-white p-3 rounded-lg shadow-md shrink-0">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
                        </svg>
                    </div>
                    <div>
                        <h1 class="text-2xl font-extrabold text-gray-800 tracking-tight">
                            KANBAN <span class="text-gray-400 font-normal">CONVERSIÓN</span>
                        </h1>
                        <div class="flex items-center gap-2 text-xs font-semibold text-gray-500 mt-1">
                            <span class="w-2 h-2 rounded-full bg-green-500 animate-pulse"></span>
                            ACTUALIZACIÓN EN TIEMPO REAL
                        </div>
                    </div>
                </div>

                <div class="flex gap-8 text-right self-end md:self-auto">
                    <div>
                        <p class="text-xs text-gray-400 font-bold tracking-wider">EFICIENCIA GLOBAL</p>
                        <p class="text-2xl font-black text-gray-800 smooth-transition" id="global-efficiency">0%</p>
                    </div>
                    <div>
                        <p class="text-xs text-gray-400 font-bold tracking-wider">ALERTAS ROJAS</p>
                        <p class="text-2xl font-black smooth-transition text-gray-800" id="global-alerts">0</p>
                    </div>
                </div>
            </header>

            <!-- KPI CARDS -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex items-center gap-4">
                    <div class="p-3 bg-indigo-50 text-indigo-600 rounded-xl">
                        <svg class="h-8 w-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path></svg>
                    </div>
                    <div>
                        <p class="text-xs font-bold text-gray-400 uppercase">Total Bobinas</p>
                        <p class="text-3xl font-black text-gray-800 mt-1 smooth-transition" id="kpi-transit">0</p>
                    </div>
                </div>
                <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex items-center gap-4">
                    <div class="p-3 bg-red-50 text-red-500 rounded-xl">
                        <svg class="h-8 w-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path></svg>
                    </div>
                    <div>
                        <p class="text-xs font-bold text-gray-400 uppercase">Líneas en Rojo</p>
                        <p class="text-3xl font-black text-gray-800 mt-1 smooth-transition" id="kpi-critical">0</p>
                    </div>
                </div>
                <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex items-center gap-4">
                    <div class="p-3 bg-green-50 text-green-500 rounded-xl">
                        <svg class="h-8 w-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path></svg>
                    </div>
                    <div>
                        <p class="text-xs font-bold text-gray-400 uppercase">Capacidad Global</p>
                        <p class="text-3xl font-black text-gray-800 mt-1 smooth-transition" id="kpi-performance">0%</p>
                    </div>
                </div>
                <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex items-center gap-4">
                    <div class="p-3 bg-blue-50 text-blue-500 rounded-xl">
                        <svg class="h-8 w-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    </div>
                    <div>
                        <p class="text-xs font-bold text-gray-400 uppercase">Estado Planta</p>
                        <p class="text-2xl font-black text-gray-800 mt-1 smooth-transition" id="kpi-status">Conectando...</p>
                    </div>
                </div>
            </div>

            <!-- GRID DE MÁQUINAS (Se renderiza desde SQL Server) -->
            <div id="lines-container" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 xl:grid-cols-7 gap-4 flex-grow">
                <!-- Renderizado dinámico por JS -->
            </div>

        </div> <!-- CIERRE DEL CONTENEDOR TIPO BODY -->
    </div> <!-- CIERRE DEL RECUADRO CON BORDE VERDE PAVECA -->

    <!-- SCRIPT JS -->
    <script>
        let isFirstLoad = true;

        // --- 1. LLAMADA AL SERVIDOR (.NET WEB METHOD) ---
        const fetchApiData = async () => {
            try {
                // Obtiene la ruta actual (Ej: Kanvan.aspx) y le añade el WebMethod
                const apiUrl = window.location.pathname + '/ObtenerDatosPlanta';

                const response = await fetch(apiUrl, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json; charset=utf-8' },
                    body: JSON.stringify({})
                });

                const result = await response.json();
                return result.d; // WebForms encapsula el JSON en 'd'
            } catch (error) {
                console.error("Error conectando al servidor:", error);
                return [];
            }
        };

        // --- 2. LÓGICA DE COLORES DEL PDF (A, B, C) ---
        const getStatusConfig = (estado, mensaje) => {
            if (estado === "Rojo") {
                return { label: mensaje, hex: "#EF4444", bgClass: "bg-red-500", bgLight: "bg-red-50", textDark: "text-red-600", barColor: "bg-red-500", borderClass: "border-red-200" };
            } else if (estado === "Amarillo") {
                return { label: mensaje, hex: "#F59E0B", bgClass: "bg-yellow-500", bgLight: "bg-yellow-50", textDark: "text-yellow-600", barColor: "bg-yellow-500", borderClass: "border-yellow-200" };
            } else {
                return { label: mensaje, hex: "#10B981", bgClass: "bg-green-500", bgLight: "bg-green-50", textDark: "text-green-600", barColor: "bg-green-500", borderClass: "border-green-200" };
            }
        };

        // --- 3. DIBUJAR TARJETAS LA PRIMERA VEZ ---
        const initDashboard = (data) => {
            const container = document.getElementById("lines-container");
            container.innerHTML = "";

            data.forEach((line) => {
                const card = document.createElement("div");
                card.id = `card-${line.id}`;
                card.className = "bg-white rounded-2xl shadow-md p-4 flex flex-col items-center justify-between relative overflow-hidden h-96 transition-all duration-500 hover:shadow-lg border border-transparent";

                card.innerHTML = `
                    <div id="top-bar-${line.id}" class="absolute top-0 left-0 w-full h-2 smooth-transition bg-gray-200"></div>
                    <div id="dot-${line.id}" class="absolute top-4 right-4 w-3 h-3 rounded-full smooth-transition bg-gray-200"></div>

                    <div class="w-full text-center mt-4 z-10">
                        <h3 class="text-lg font-black text-gray-400 uppercase tracking-wider">${line.name}</h3>
                        <span id="badge-${line.id}" class="inline-block mt-2 px-3 py-1 text-xs font-bold rounded-full smooth-transition border border-transparent text-gray-500 bg-gray-100">
                            Cargando...
                        </span>
                    </div>

                    <div class="relative w-40 h-40 flex items-center justify-center">
                        <svg class="w-full h-full" viewBox="0 0 120 120">
                            <circle class="text-gray-100" stroke-width="8" stroke="currentColor" fill="transparent" r="50" cx="60" cy="60" />
                            <circle id="circle-${line.id}" class="progress-circle" stroke="gray" stroke-width="8" stroke-linecap="round" fill="transparent" r="50" cx="60" cy="60" style="stroke-dasharray: 314.159; stroke-dashoffset: 314.159;" />
                        </svg>
                        <div class="absolute inset-0 flex flex-col items-center justify-center">
                            <span id="number-${line.id}" class="text-5xl font-black text-gray-800 number-ticker smooth-transition">0</span>
                            <span class="text-[10px] font-bold text-gray-400 uppercase mt-1">BOBINAS</span>
                            <span class="text-[9px] text-gray-300">Cap Max: ${line.max}</span>
                        </div>
                    </div>

                    <div id="bars-${line.id}" class="flex gap-1 w-full justify-center px-2 mb-2 h-2 mt-4"></div>
                `;
                container.appendChild(card);

                const barsContainer = document.getElementById(`bars-${line.id}`);
                for (let i = 0; i < line.max; i++) {
                    const bar = document.createElement("div");
                    bar.className = "h-full w-full rounded-full bg-gray-100 smooth-transition";
                    bar.id = `line-${line.id}-bar-${i}`;
                    barsContainer.appendChild(bar);
                }
            });
        };

        // --- 4. ACTUALIZAR LOS DATOS Y ANIMACIONES ---
        const updateDashboard = async () => {
            const data = await fetchApiData();

            if (!data || data.length === 0) return;

            if (isFirstLoad) {
                initDashboard(data);
                isFirstLoad = false;
            }

            let totalLots = 0;
            let criticalCount = 0;
            let totalMaxCapacity = 0;

            data.forEach((line) => {
                const config = getStatusConfig(line.estado, line.mensaje);

                totalLots += line.current;
                totalMaxCapacity += line.max;
                if (line.estado === "Rojo") criticalCount++;

                document.getElementById(`top-bar-${line.id}`).className = `absolute top-0 left-0 w-full h-2 smooth-transition ${config.bgClass}`;
                document.getElementById(`dot-${line.id}`).className = `absolute top-4 right-4 w-3 h-3 rounded-full smooth-transition ${config.bgClass} ${line.estado === "Rojo" ? "animate-ping" : ""}`;

                const badge = document.getElementById(`badge-${line.id}`);
                badge.className = `inline-block mt-2 px-3 py-1 text-xs font-bold rounded-full smooth-transition border ${config.bgLight} ${config.textDark} ${config.borderClass}`;
                badge.innerText = config.label;

                const circle = document.getElementById(`circle-${line.id}`);
                const circumference = 2 * Math.PI * 50;
                const percentage = Math.min((line.current / line.max) * 100, 100);
                const offset = circumference - (percentage / 100) * circumference;

                circle.style.strokeDashoffset = offset < 0 ? 0 : offset;
                circle.style.stroke = config.hex;

                const numberEl = document.getElementById(`number-${line.id}`);
                if (numberEl.innerText !== line.current.toString()) {
                    numberEl.classList.add("scale-125", config.textDark);
                    setTimeout(() => numberEl.classList.remove("scale-125", config.textDark), 300);
                }
                numberEl.innerText = line.current;

                for (let i = 0; i < line.max; i++) {
                    const bar = document.getElementById(`line-${line.id}-bar-${i}`);
                    if (bar) {
                        bar.className = (i < line.current)
                            ? `h-full w-full rounded-full smooth-transition ${config.barColor}`
                            : "h-full w-full rounded-full bg-gray-100 smooth-transition";
                    }
                }
            });

            const efficiency = totalMaxCapacity > 0 ? Math.round((totalLots / totalMaxCapacity) * 100) : 0;

            updateKpi("kpi-transit", totalLots);
            updateKpi("kpi-critical", criticalCount, criticalCount > 0 ? "text-red-600" : "text-gray-800");
            updateKpi("global-alerts", criticalCount, criticalCount > 0 ? "text-red-500" : "text-gray-400");

            document.getElementById("kpi-performance").innerText = `${efficiency}%`;
            document.getElementById("global-efficiency").innerText = `${efficiency}%`;

            const statusEl = document.getElementById("kpi-status");
            if (criticalCount === 0) {
                statusEl.innerText = "Estable";
                statusEl.className = "text-2xl font-black text-green-600 mt-1 smooth-transition";
            } else if (criticalCount <= 2) {
                statusEl.innerText = "Precaución";
                statusEl.className = "text-2xl font-black text-yellow-500 mt-1 smooth-transition";
            } else {
                statusEl.innerText = "Crítico";
                statusEl.className = "text-2xl font-black text-red-600 mt-1 smooth-transition animate-pulse";
            }
        };

        function updateKpi(id, newValue, colorClass = null) {
            const el = document.getElementById(id);
            if (el.innerText != newValue) {
                el.innerText = newValue;
                if (colorClass) el.className = `text-3xl font-black mt-1 smooth-transition ${colorClass}`;
            }
        }

        // --- INICIAR SISTEMA ---
        updateDashboard();
        setInterval(updateDashboard, 30000);

    </script>
</asp:Content>