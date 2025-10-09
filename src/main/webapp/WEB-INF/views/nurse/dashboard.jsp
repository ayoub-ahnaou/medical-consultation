<%@ include file="../layout/header.jsp" %>
<h1>Welcome, Nurse!</h1>
<p>This is your dashboard. You can view and manage patient information here.</p>
<a href="<%= request.getContextPath() %>/logout">Logout</a>
<%@ include file="../layout/footer.jsp" %>
