<%@ Page Title="Zona Confidencial" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Misterio.aspx.cs" Inherits="Prueba.Misterio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="card shadow-lg">
            <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Portal PAVECA</h5>
                <!-- Botón necesario para el evento btnLogout_Click -->
                <asp:Button ID="btnLogout" runat="server" Text="Cerrar Sesión" CssClass="btn btn-sm btn-danger" OnClick="btnLogout_Click" />
            </div>
            <div class="card-body text-center p-5">
                <!-- Etiqueta necesaria para lblUsuario.Text -->
                <h1 class="mb-4">Bienvenido, <asp:Label ID="lblUsuario" runat="server" Text="Usuario" ForeColor="#005A36"></asp:Label></h1>
                <p class="lead">Has ingresado al sistema correctamente.</p>
            </div>
        </div>
    </div>
</asp:Content>