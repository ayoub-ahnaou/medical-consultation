<%@ include file="layout/header.jsp" %>

<div class="flex items-center justify-center min-h-screen bg-gray-100">
    <form method="post" action="login" class="bg-white shadow-md rounded-lg p-8 w-full max-w-md">
        <h2 class="text-2xl font-bold text-center mb-6 text-gray-800">Login</h2>

        <div class="mb-4">
            <label for="username" class="block text-gray-700 font-medium mb-1">Username</label>
            <input type="text" name="username" id="username" placeholder="Username" required
                   class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"/>
        </div>

        <div class="mb-4">
            <label for="password" class="block text-gray-700 font-medium mb-1">Password</label>
            <input type="password" name="password" id="password" placeholder="Password" required
                   class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"/>
        </div>

        <button type="submit"
                class="w-full bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700 transition-colors font-semibold">
            Login
        </button>

        <c:if test="${not empty error}">
            <div class="mt-4 text-red-600 text-center font-medium">${error}</div>
        </c:if>
    </form>
</div>

<%@ include file="layout/footer.jsp" %>
