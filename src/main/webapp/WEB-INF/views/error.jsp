<%@ include file="layout/header.jsp" %>
<%@ page isErrorPage="true" %>

<div class="container mx-auto px-4 py-8 max-w-7xl">
    <!-- Error Icon -->
    <div class="flex justify-center mb-4">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 text-red-600" fill="none"
             viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M12 9v2m0 4h.01M4.93 4.93l14.14 14.14M19.07 4.93L4.93 19.07" />
        </svg>
    </div>

    <!-- Title -->
    <h1 class="text-2xl font-bold text-red-600 mb-2">An error occurred</h1>

    <!-- Message from Servlet -->
    <p class="text-gray-600 mb-4">
        <%= (request.getAttribute("error") != null)
                ? request.getAttribute("error")
                : "An unexpected error occurred while processing your request." %>
    </p>

    <!-- Exception stack trace (only in development) -->
    <%
        if (exception != null) {
    %>
    <div class="bg-red-50 text-red-700 text-sm rounded-md p-3 text-left overflow-x-auto mb-4">
        <strong><%= exception.getClass().getSimpleName() %>:</strong> <%= exception.getMessage() %><br>
        <pre class="mt-2 whitespace-pre-wrap text-xs">
<%
    exception.printStackTrace(new java.io.PrintWriter(out));
%>
                </pre>
    </div>
    <%
        }
    %>

    <!-- Back button -->
    <a href="<%= request.getContextPath() %>/dashboard"
       class="inline-block bg-blue-600 hover:bg-blue-700 text-white px-5 py-2 rounded-lg font-medium transition">
        ⬅ Back to Dashboard
    </a>
</div>

</body>
</html>
