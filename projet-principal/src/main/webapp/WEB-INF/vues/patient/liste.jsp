<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="mg.itu.model.Patient" %>
<%!
    // evite qu'un nom contenant < ou " casse la page
    static String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
%>
<html>
<head><title>Liste des patients</title></head>
<body>
    <h1>Liste des patients</h1>
    <p>
        Connecte : <b><%= esc((String) session.getAttribute("utilisateur_connecte")) %></b>
        (<%= esc((String) session.getAttribute("role_utilisateur")) %>)
        - <a href="<%= request.getContextPath() %>/logout">Deconnexion</a>
    </p>

    <p><a href="<%= request.getContextPath() %>/patient/form?id=0">+ Nouveau patient</a></p>

    <table border="1" cellpadding="5">
        <tr>
            <th>ID</th><th>Nom</th><th>Prenom</th><th>Date de naissance</th>
            <th>Sexe</th><th>Telephone</th><th>Actions</th>
        </tr>
    <%
        List<Patient> liste = (List<Patient>) request.getAttribute("listePatient");
        if (liste != null) {
            for (Patient p : liste) {
    %>
        <tr>
            <td><%= p.getId() %></td>
            <td><%= esc(p.getNom()) %></td>
            <td><%= esc(p.getPrenom()) %></td>
            <td><%= esc(p.getDateNaissance()) %></td>
            <td><%= esc(p.getSexe()) %></td>
            <td><%= esc(p.getTelephone()) %></td>
            <td>
                <a href="<%= request.getContextPath() %>/patient/fiche?id=<%= p.getId() %>">Fiche</a>
                <a href="<%= request.getContextPath() %>/patient/form?id=<%= p.getId() %>">Modifier</a>
                <form method="post" action="<%= request.getContextPath() %>/patient/delete" style="display:inline"
                      onsubmit="return confirm('Supprimer ce patient ?');">
                    <input type="hidden" name="id" value="<%= p.getId() %>"/>
                    <button type="submit">Supprimer</button>
                </form>
            </td>
        </tr>
    <%
            }
        }
    %>
    </table>
</body>
</html>