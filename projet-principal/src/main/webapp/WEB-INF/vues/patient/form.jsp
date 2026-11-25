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
    boolean modif = p.getId() > 0;
%>
<html>
<head><title><%= modif ? "Modifier" : "Nouveau" %> patient</title></head>
<body>
    <h1><%= modif ? "Modifier le patient" : "Nouveau patient" %></h1>

    <!-- les "name" doivent etre les memes que les attributs de Patient.java -->
    <form method="post" action="<%= request.getContextPath() %>/patient/save">
        <input type="hidden" name="id" value="<%= p.getId() %>"/>

        <p>Nom : <input type="text" name="nom" value="<%= esc(p.getNom()) %>" required/></p>
        <p>Prenom : <input type="text" name="prenom" value="<%= esc(p.getPrenom()) %>" required/></p>
        <p>Date de naissance : <input type="date" name="dateNaissance" value="<%= esc(p.getDateNaissance()) %>"/></p>
        <p>Sexe :
            <select name="sexe">
                <option value="">--</option>
                <option value="M" <%= "M".equals(p.getSexe()) ? "selected" : "" %>>Masculin</option>
                <option value="F" <%= "F".equals(p.getSexe()) ? "selected" : "" %>>Feminin</option>
            </select>
        </p>
        <p>Adresse : <input type="text" name="adresse" value="<%= esc(p.getAdresse()) %>"/></p>
        <p>Telephone : <input type="text" name="telephone" value="<%= esc(p.getTelephone()) %>"/></p>
        <p>Email : <input type="text" name="email" value="<%= esc(p.getEmail()) %>"/></p>

        <button type="submit">Enregistrer</button>
        <a href="<%= request.getContextPath() %>/patient/list">Annuler</a>
    </form>
</body>
</html>