<%@ include file="../layout/header.jsp" %>

<h1>Welcome, Nurse!</h1>
<p>This is your dashboard. You can view and manage patient information here.</p>

<div class="bg-white rounded-xl shadow-md p-6">
    <h2 class="text-xl font-semibold text-blue-700 mb-4 flex items-center">
        <i class="fas fa-user-plus mr-2"></i>Ajouter un nouveau patient
    </h2>

    <c:if test="${not empty success}">
        <div class="bg-green-50 border-l-4 border-green-500 p-4 rounded-lg mb-4">
            <p class="text-green-800 font-medium">${success}</p>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="bg-red-50 border-l-4 border-red-500 p-4 rounded-lg mb-4">
            <p class="text-red-800 font-medium">${error}</p>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/addPatient" method="post">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
                <label class="block text-gray-700 text-sm font-medium mb-1" for="firstName">Prénom</label>
                <input type="text" id="firstName" name="firstName" placeholder="Prénom" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            </div>

            <div>
                <label class="block text-gray-700 text-sm font-medium mb-1" for="lastName">Nom</label>
                <input type="text" id="lastName" name="lastName" placeholder="Nom" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            </div>

            <div>
                <label class="block text-gray-700 text-sm font-medium mb-1" for="phone">Téléphone</label>
                <input type="text" id="phone" name="phone" placeholder="Téléphone" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            </div>

            <div>
                <label class="block text-gray-700 text-sm font-medium mb-1" for="dateOfBirth">Date de naissance</label>
                <input type="date" id="dateOfBirth" name="dateOfBirth" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            </div>

            <div>
                <label class="block text-gray-700 text-sm font-medium mb-1" for="height">Taille (cm)</label>
                <input type="number" id="height" name="height" step="0.1" placeholder="Taille (cm)" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            </div>

            <div>
                <label class="block text-gray-700 text-sm font-medium mb-1" for="weight">Poids (kg)</label>
                <input type="number" id="weight" name="weight" step="0.1" placeholder="Poids (kg)" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            </div>

            <div>
                <label class="block text-gray-700 text-sm font-medium mb-1" for="gender">Genre</label>
                <select id="gender" name="gender" required
                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    <option value="">Sélectionner le genre</option>
                    <option value="MALE">Homme</option>
                    <option value="FEMALE">Femme</option>
                </select>
            </div>
        </div>

        <input type="hidden" name="role" value="PATIENT">
        <div class="mt-6">
            <button type="submit"
                    class="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-3 px-4 rounded-lg transition duration-200 flex items-center justify-center">
                <i class="fas fa-save mr-2"></i>Enregistrer le patient
            </button>
        </div>
    </form>
</div>

<%@ include file="../layout/footer.jsp" %>
