<%@ include file="../layout/header.jsp" %>

<div class="container mx-auto px-4 py-8 max-w-7xl">
    <!-- Success Icon -->
    <div class="flex justify-center mb-4">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 text-green-600" fill="none"
             viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M5 13l4 4L19 7"/>
        </svg>
    </div>

    <!-- Title -->
    <h1 class="text-2xl font-bold text-green-600 mb-2">Success!</h1>

    <!-- Message from Servlet -->
    <p class="text-gray-600 mb-4">
        <%= (request.getAttribute("message") != null)
                ? request.getAttribute("message")
                : "The operation was completed successfully." %>
    </p>

    <!-- Optional: Display consultation details -->
    <c:if test="${not empty consultation}">
        <div class="bg-green-50 text-green-800 text-sm rounded-md p-3 text-left mb-4">
            <p><strong>Consultation ID:</strong> ${consultation.id}</p>
            <c:if test="${not empty totalPrice}">
                <p><strong>Total Price:</strong> $${totalPrice}</p>
            </c:if>
        </div>
    </c:if>

    <!-- Back button -->
    <a href="<%= request.getContextPath() %>/dashboard"
       class="inline-block bg-blue-600 hover:bg-blue-700 text-white px-5 py-2 rounded-lg font-medium transition">
        ⬅ Back to Dashboard
    </a>
</div>

</body>
</html>
