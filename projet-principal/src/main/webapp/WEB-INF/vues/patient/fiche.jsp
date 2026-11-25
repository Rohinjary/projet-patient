<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="mg.itu.model.Patient" %>
<%!
    static String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
%>
<%
    Patient p = (Patient) request.getAttribute("patient");
    boolean medecin = "medecin".equals(session.getAttribute("role_utilisateur"));
%>
<html>
<head><title>Fiche patient</title></head>
<body>
    <h1>Fiche patient</h1>
    <p>
        Connecte : <b><%= esc((String) session.getAttribute("utilisateur_connecte")) %></b>
        - <a href="<%= request.getContextPath() %>/logout">Deconnexion</a>
    </p>

    <table border="1" cellpadding="5">
        <tr><th>ID</th><td><%= p.getId() %></td></tr>
        <tr><th>Nom</th><td><%= esc(p.getNom()) %></td></tr>
        <tr><th>Prenom</th><td><%= esc(p.getPrenom()) %></td></tr>
        <tr><th>Date de naissance</th><td><%= esc(p.getDateNaissance()) %></td></tr>
        <tr><th>Sexe</th><td><%= esc(p.getSexe()) %></td></tr>
        <tr><th>Adresse</th><td><%= esc(p.getAdresse()) %></td></tr>
        <tr><th>Telephone</th><td><%= esc(p.getTelephone()) %></td></tr>
        <tr><th>Email</th><td><%= esc(p.getEmail()) %></td></tr>
    </table>

    <!-- Sprint 2 : l'image du QR code sera affichee ici -->

    <% if (medecin) { %>
        <p>
            <a href="<%= request.getContextPath() %>/patient/form?id=<%= p.getId() %>">Modifier</a>
            - <a href="<%= request.getContextPath() %>/patient/list">Retour a la liste</a>
        </p>
    <% } %>
</body>
</html>