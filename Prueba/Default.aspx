<%@ Page Title="Página Principal" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Prueba._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Estilos específicos para esta página -->
    <style>
        .text-paveca { color: #007853; }
        .bg-paveca-light { background-color: #f0f7f5; }
        .btn-paveca { background-color: #007853; color: white; border: 1px solid #007853; }
        .btn-paveca:hover { background-color: #005f42; color: white; }
        .btn-outline-paveca { color: #007853; border: 1px solid #007853; background: transparent; }
        .btn-outline-paveca:hover { background-color: #007853; color: white; }
        
        /* Efecto de elevación para las tarjetas de servicios */
        .service-card { transition: transform 0.3s ease, box-shadow 0.3s ease; border: 1px solid #eee; }
        .service-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.08); border-color: #007853; }
        
        .icon-box {
            width: 60px; height: 60px;
            background-color: #e6f2ed;
            color: #007853;
            display: flex; align-items: center; justify-content: center;
            border-radius: 50%;
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
        }
    </style>

    <main>
        <!-- CONTENEDOR PRINCIPAL TIPO TARJETA -->
        <div class="bg-white mx-auto shadow-sm my-5" style="max-width:1200px; border-radius:8px; border-top: 5px solid #007853; overflow: hidden;">
            
            <!-- SECCIÓN HERO (Intro) -->
            <div class="p-5">
                <div class="row align-items-center g-5">
                    
                    <!-- Columna Izquierda: Texto Principal -->
                    <div class="col-lg-7">
                        <span class="badge bg-paveca-light text-paveca mb-3 px-3 py-2 rounded-pill fw-bold">Líderes en Venezuela 🇻🇪</span>
                        <h1 class="fw-bold display-5 mb-4 text-dark">Soluciones papeleras para un país que produce.</h1>
                        <p class="lead text-muted mb-4" style="line-height: 1.6;">
                            <strong> Fabricamos y convertimos productos confiables para el cuidado del hogar y uso industrial, 
                            con procesos responsables y una calidad consistente que nos respalda desde hace décadas.</strong>
                        </p>

                        <div class="d-flex flex-wrap gap-3">
                            <a href="/Contact.aspx" class="btn btn-paveca px-4 py-2 rounded-pill fw-bold">Habla con nosotros</a>
                            <a href="/About.aspx" class="btn btn-outline-paveca px-4 py-2 rounded-pill fw-bold">Conoce PAVECA</a>
                        </div>

                        <!-- Pequeños puntos de confianza -->
                        <div class="d-flex align-items-center gap-4 mt-5 text-muted small fw-bold">
                            <div class="d-flex align-items-center gap-2">
                                <i class="bi bi-check-circle-fill text-paveca"></i> Calidad Certificada
                            </div>
                            <div class="d-flex align-items-center gap-2">
                                <i class="bi bi-check-circle-fill text-paveca"></i> Sostenibilidad
                            </div>
                        </div>
                    </div>

                    <!-- Columna Derecha: KPIs (Estadísticas) -->
                    <div class="col-lg-5">
                        <div class="bg-paveca-light p-4 rounded-3 text-center">
                            <h5 class="text-paveca fw-bold mb-4">Nuestro Impacto</h5>
                            
                            <div class="row g-3">
                                <div class="col-6">
                                    <div class="bg-white p-3 rounded shadow-sm h-100">
                                        <h2 class="fw-bold text-dark mb-0">73</h2>
                                        <small class="text-muted">Años de trayectoria</small>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="bg-white p-3 rounded shadow-sm h-100">
                                        <h2 class="fw-bold text-dark mb-0">+1000</h2>
                                        <small class="text-muted">Colaboradores</small>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="bg-white p-3 rounded shadow-sm">
                                        <h2 class="fw-bold text-dark mb-0">100%</h2>
                                        <small class="text-muted">Compromiso Nacional</small>
                                    </div>
                                </div>
                            </div>
                            
                            <p class="mt-4 mb-0 small text-muted">
                                <i class="bi bi-info-circle me-1"></i> Cadena integrada: pulpa, papel y conversión.
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <hr class="mx-5 opacity-25">

            <!-- SECCIÓN DE SERVICIOS / CARACTERÍSTICAS -->
            <div class="p-5">
                <div class="row g-4">
                    <!-- Tarjeta 1 -->
                    <div class="col-md-4">
                        <div class="service-card p-4 rounded-3 h-100 bg-white">
                            <div class="icon-box">
                                <i class="bi bi-layers-fill"></i>
                            </div>
                            <h4 class="fw-bold mb-3">Papel & Celulosa</h4>
                            <p class="text-muted">
                                Fabricación de papeles base con estrictos controles de calidad en cada bobina para garantizar resistencia y suavidad.
                            </p>
                        </div>
                    </div>

                    <!-- Tarjeta 2 -->
                    <div class="col-md-4">
                        <div class="service-card p-4 rounded-3 h-100 bg-white">
                            <div class="icon-box">
                                <i class="bi bi-box-seam-fill"></i>
                            </div>
                            <h4 class="fw-bold mb-3">Conversión & Empaque</h4>
                            <p class="text-muted">
                                Toallas, servilletas, tissue y soluciones listas para retail y B2B, adaptadas a las necesidades del mercado actual.
                            </p>
                        </div>
                    </div>

                    <!-- Tarjeta 3 -->
                    <div class="col-md-4">
                        <div class="service-card p-4 rounded-3 h-100 bg-white">
                            <div class="icon-box">
                                <i class="bi bi-tree-fill"></i>
                            </div>
                            <h4 class="fw-bold mb-3">Sostenibilidad</h4>
                            <p class="text-muted">
                                Uso eficiente de agua y energía, programas de reciclaje y mejora continua para reducir nuestra huella ambiental.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer interno pequeño -->
            <div class="text-center py-3 bg-light border-top">
                <small class="text-muted">© 2026 Papeles Venezolanos C.A. - Todos los derechos reservados.</small>
            </div>

        </div>
    </main>

</asp:Content>