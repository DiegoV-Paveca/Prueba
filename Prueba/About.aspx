<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Prueba.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
            <div class="bg-white p-5 my-3 mx-auto" style="max-width:1200px;border-radius:2px;">

      <!-- Contenedor fluido sin padding para que la imagen toque los bordes -->
<div class="container-fluid p-0">
    <!-- Fila que ocupa al menos el 100% del alto de la pantalla (min-vh-100) -->
    <div class="row m-0 min-vh-100">
        
        <!-- MITAD IZQUIERDA: Imagen -->
        <!-- En móviles (col-12) ocupará arriba, en PC (col-lg-6) ocupará la mitad izquierda -->
        <div class="col-12 col-lg-6 p-0 position-relative" style="min-height: 400px;">
            <!-- Cambia el src por la ruta de tu imagen real-->
            <img src="../imagenes/productos.png" 
                 alt="Equipo PAVECA" 
                 class="position-absolute w-100 h-100" 
                 style="object-fit: cover;" />
        </div>

        <!-- MITAD DERECHA: Contenido -->
        <div class="col-12 col-lg-6 d-flex flex-column justify-content-center p-5 bg-white">

            
            <!-- Contenedor interno para limitar el ancho del texto y centrarlo -->
            <div style="max-width: 600px; margin: 0 auto;">
                
                <h2 class="mb-5 font-weight-bold" style="font-size: 2.5rem; color: #1a1a1a;">
                    Sobre PAVECA.
                </h2>
                        <hr class="mt-3" style="opacity:.15;" />


                <!-- ITEM 1: Historia y Trayectoria -->
                <div class="d-flex align-items-start mb-5">
                    <!-- Ícono de Rollo de Papel -->
                    <div class="flex-shrink-0 mt-1" style="margin-right: 1.5rem;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" stroke-width="1.5" stroke="#1a1a1a" fill="none" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M9 5.25a3 1.5 0 0 0 6 0a3 1.5 0 0 0 -6 0" />
                            <path d="M3 5.25a9 3 0 0 0 18 0a9 3 0 0 0 -18 0" />
                            <path d="M3 5.25v10.5a9 3 0 0 0 18 0v-10.5" />
                            <path d="M21 15.75v4.25a1 1 0 0 1 -1 1h-10a1 1 0 0 1 -1 -1v-4.25" />
                            <path d="M9 15.75a9 3 0 0 0 12 0" />
                        </svg>
                    </div>
                    
                    <!-- Texto -->
                    <div>
                        <h4 id="aspnetTitle1" class="font-weight-bold mb-2" style="font-size: 1.25rem;">Historia y Trayectoria</h4>
                        <p class="text-muted" style="line-height: 1.6; font-size: 0.95rem;">
                            Papel Venezolano, C. A. (PAVECA), fundado en febrero de 1953 en la ciudad 
                            de Guacara, estado Carabobo, es una de las pioneras y principales productoras de papel 
                            tissue de América Latina.                             <br/><br/>
                            Se ubica en la carretera nacional Guacara - San Joaquín, 
                            kilómetro 1, Edo. Carabobo.Desde hace más de 60 años PAVECA ha sido sinónimo 
                            de confianza, esfuerzo y tradición para todos los venezolanos                        </p>
                    </div>
                </div>
                        <hr class="mt-3" style="opacity:.15;" />

                <!-- ITEM 2: Misión y Enfoque -->
                <div class="d-flex align-items-start mb-5">
                    <!-- Ícono de Rollo de Papel -->
                    <div class="flex-shrink-0 mt-1" style="margin-right: 1.5rem;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" stroke-width="1.5" stroke="#1a1a1a" fill="none" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M9 5.25a3 1.5 0 0 0 6 0a3 1.5 0 0 0 -6 0" />
                            <path d="M3 5.25a9 3 0 0 0 18 0a9 3 0 0 0 -18 0" />
                            <path d="M3 5.25v10.5a9 3 0 0 0 18 0v-10.5" />
                            <path d="M21 15.75v4.25a1 1 0 0 1 -1 1h-10a1 1 0 0 1 -1 -1v-4.25" />
                            <path d="M9 15.75a9 3 0 0 0 12 0" />
                        </svg>
                    </div>
                    
                    <!-- Texto -->
                    <div>
                        <h4 id="aspnetTitle2" class="font-weight-bold mb-2" style="font-size: 1.25rem;">Misión y enfoque</h4>
                        <p class="text-muted" style="line-height: 1.6; font-size: 0.95rem;">
                            PAVECA tiene como misión mantener el liderazgo como empresa 
                        estratégicamente integrada, haciendo el mejor papel del mercado para cuidado personal 
                        y del hogar, que satisfaga las necesidades de los consumidores, clientes, accionistas y 
                        el talento humano que labora en ella, creando conciencia ambiental y con 
                        responsabilidad social. 

                            <br/><br/>
                    La visión de PAVECA es la de consolidar su liderazgo a través del talento 
                    humano, capacidades productivas y de comercialización, incursionando en nuevos 
                    mercados nacionales e internacionales, mediante la diversificación de productos.                         </p>
                                <hr class="mt-3" style="opacity:.15;" />

                    </div>
                </div>

            </div>
        </div>

    </div>
</div>
</div>
</main>
</asp:Content>