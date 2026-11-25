<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Connexion</title></head>
<body>
    <h1>Connexion</h1>

    <%
        String erreur = (String) request.getAttribute("erreur");
        if (erreur != null) {
    %>
        <p style="color:red"><%= erreur %></p>
    <%
        }
    %>

    <form method="post" action="<%= request.getContextPath() %>/login">
        <p><input type="text" name="login" placeholder="Login"/></p>
        <p><input type="password" name="motDePasse" placeholder="Mot de passe"/></p>
        <button type="submit">Se connecter</button>
    </form>
</body>
</html>