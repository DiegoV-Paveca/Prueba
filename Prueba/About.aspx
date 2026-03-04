<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Prueba.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        
        <!-- Recuadro principal con el estilo solicitado -->
        <div class="bg-white mx-auto shadow-sm my-5" style="max-width:1200px; border-radius:8px; border-top: 5px solid #007853; overflow: hidden;">

            <div class="row g-0"> <!-- g-0 elimina los espacios entre columnas para que se vea unido -->
                
                <!-- MITAD IZQUIERDA: Imagen -->
                <!-- En PC (col-lg-6) ocupa la mitad. En móvil va arriba. -->
                <div class="col-12 col-lg-6 position-relative" style="min-height: 400px;">
                    <!-- Ajusté la imagen para que cubra todo el lado izquierdo sin bordes blancos extra -->
                    <img src="../imagenes/productos.png" 
                         alt="Equipo PAVECA" 
                         class="w-100 h-100" 
                         style="object-fit: cover; position: absolute; top: 0; left: 0;" />
                </div>

                <!-- MITAD DERECHA: Contenido -->
                <div class="col-12 col-lg-6 p-5">
                    
                    <div style="max-width: 600px; margin: 0 auto;">
                        
                        <h2 class="mb-4 fw-bold" style="font-size: 2.5rem; color: #1a1a1a;">
                            Sobre PAVECA.
                        </h2>
                        <hr class="mb-5" style="opacity:.15;" />

                        <!-- ITEM 1: Historia y Trayectoria -->
                        <div class="d-flex align-items-start mb-4">
                            <div class="flex-shrink-0 mt-1 me-3">
                                <!-- Icono SVG -->
                                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" stroke-width="1.5" stroke="#007853" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M9 5.25a3 1.5 0 0 0 6 0a3 1.5 0 0 0 -6 0" />
                                    <path d="M3 5.25a9 3 0 0 0 18 0a9 3 0 0 0 -18 0" />
                                    <path d="M3 5.25v10.5a9 3 0 0 0 18 0v-10.5" />
                                    <path d="M21 15.75v4.25a1 1 0 0 1 -1 1h-10a1 1 0 0 1 -1 -1v-4.25" />
                                    <path d="M9 15.75a9 3 0 0 0 12 0" />
                                </svg>
                            </div>
                            <div>
                                <h4 class="fw-bold mb-2" style="font-size: 1.25rem;">Historia y Trayectoria</h4>
                                <p class="text-muted" style="line-height: 1.6; font-size: 0.95rem;">
                                    Papel Venezolano, C. A. (PAVECA), fundado en febrero de 1953 en la ciudad 
                                    de Guacara, estado Carabobo, es una de las pioneras y principales productoras de papel 
                                    tissue de América Latina.
                                    <br/><br/>
                                    Desde hace más de 60 años PAVECA ha sido sinónimo de confianza, esfuerzo y tradición.
                                </p>
                            </div>
                        </div>

                        <hr class="my-4" style="opacity:.15;" />

                        <!-- ITEM 2: Misión y Enfoque -->
                        <div class="d-flex align-items-start">
                            <div class="flex-shrink-0 mt-1 me-3">
                                <!-- Icono SVG -->
                                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" stroke-width="1.5" stroke="#007853" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M9 5.25a3 1.5 0 0 0 6 0a3 1.5 0 0 0 -6 0" />
                                    <path d="M3 5.25a9 3 0 0 0 18 0a9 3 0 0 0 -18 0" />
                                    <path d="M3 5.25v10.5a9 3 0 0 0 18 0v-10.5" />
                                    <path d="M21 15.75v4.25a1 1 0 0 1 -1 1h-10a1 1 0 0 1 -1 -1v-4.25" />
                                    <path d="M9 15.75a9 3 0 0 0 12 0" />
                                </svg>
                            </div>
                            <div>
                                <h4 class="fw-bold mb-2" style="font-size: 1.25rem;">Misión y enfoque</h4>
                                <p class="text-muted" style="line-height: 1.6; font-size: 0.95rem;">
                                    PAVECA tiene como misión mantener el liderazgo como empresa estratégicamente integrada, 
                                    haciendo el mejor papel del mercado para cuidado personal y del hogar.
                                    <br/><br/>
                                    Nuestra visión es consolidar el liderazgo a través del talento humano y capacidades productivas.
                                </p>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
                        <div class="text-center py-3 bg-light border-top">
                <small class="text-muted">© 2026 Papeles Venezolanos C.A. - Todos los derechos reservados.</small>
            </div>
        </div>
    </main>
</asp:Content>