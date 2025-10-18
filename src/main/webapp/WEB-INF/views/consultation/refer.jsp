<%@ include file="../layout/header.jsp" %>

<div class="container mx-auto px-4 py-8 max-w-7xl">
    <h1 class="text-3xl font-bold text-gray-800 mb-8">Référencement vers un Spécialiste</h1>

    <div class="bg-white rounded-lg shadow-md p-6 border border-gray-200">
        <h2 class="text-xl font-semibold text-gray-700 mb-4 pb-2 border-b border-gray-100">Détails du référencement</h2>

        <form action="${pageContext.request.contextPath}/consultation/refer" method="post" class="space-y-6">
            <input type="hidden" name="date" id="selectedDate">
            <input type="hidden" name="time" id="selectedTime">
            <input type="hidden" name="consultationId" value="${consultationId}">
            <input type="hidden" name="generalistId" value="${generalistId}">

            <!-- Specialist Selection -->
            <div>
                <label for="specialist" class="block text-sm font-medium text-gray-700 mb-2">
                    Sélectionner un Spécialiste
                </label>
                <select name="specialistId" id="specialist" required
                        class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                        onchange="showAgendaForSpecialist(this.value)">
                    <option value="">-- Choisir un spécialiste --</option>
                    <c:forEach var="s" items="${specialists}">
                        <option value="${s.id}">Dr. ${s.firstName} ${s.lastName} - ${s.speciality}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Agenda Section -->
            <div id="agendaSection" class="hidden">
                <h3 class="text-lg font-medium text-gray-900 mb-4">Disponibilités du Spécialiste</h3>

                <!-- No Specialist Selected -->
                <div id="noSpecialistSelected" class="text-center py-8">
                    <p class="text-gray-500 italic">Veuillez sélectionner un spécialiste pour voir ses
                        disponibilités.</p>
                </div>

                <!-- No Agenda Available -->
                <div id="noAgendaAvailable" class="hidden text-center py-8">
                    <p class="text-gray-500 italic">Aucune disponibilité trouvée pour ce spécialiste.</p>
                </div>

                <!-- Agenda Containers for each specialist -->
                <c:forEach var="specialist" items="${specialists}">
                    <c:if test="${not empty specialist.agendas}">
                        <div id="agendas-${specialist.id}" class="hidden">
                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                                <c:forEach items="${specialist.agendas}" var="agenda">
                                    <label class="flex items-center p-4 border rounded-lg shadow-sm cursor-pointer transition-all duration-200 ${agenda.available ? 'bg-white hover:bg-blue-50 border-gray-200 hover:border-blue-300' : 'bg-gray-100 border-gray-300 cursor-not-allowed'}">
                                        <input type="radio" name="agendaId" value="${agenda.id}"
                                            ${!agenda.available ? 'disabled' : ''}
                                               class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded mr-3"
                                               onchange="selectAppointment(this, '${agenda.date}', '${agenda.startTime}', '${agenda.endTime}')">
                                        <div class="flex-1">
                                            <p class="text-gray-800 font-medium">
                                                <fmt:formatDate value="${agenda.date}" pattern="EEEE d MMMM yyyy"/>
                                            </p>
                                            <p class="text-gray-600 text-sm">${agenda.startTime} - ${agenda.endTime}</p>
                                            <c:if test="${not agenda.available}">
                                                <p class="text-red-500 text-xs font-medium mt-1">(Indisponible)</p>
                                            </c:if>
                                        </div>
                                    </label>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${empty specialist.agendas}">
                        <div id="agendas-${specialist.id}" class="hidden text-center py-8">
                            <p class="text-gray-500 italic">Aucun agenda disponible.</p>
                        </div>
                    </c:if>
                </c:forEach>

                <!-- Selected Appointment Display -->
                <div id="selectedAppointment" class="hidden mt-6 p-4 bg-blue-50 border border-blue-200 rounded-lg">
                    <h4 class="text-md font-semibold text-blue-800 mb-2">Rendez-vous sélectionné :</h4>
                    <p id="selectedDateTime" class="text-blue-700"></p>
                    <input type="hidden" name="consultationDate" id="selectedConsultationDate">
                </div>
            </div>

            <!-- Additional Notes -->
            <div>
                <label for="notes" class="block text-sm font-medium text-gray-700 mb-2">
                    Notes pour le spécialiste (optionnel)
                </label>
                <textarea name="description" id="notes" rows="3" required
                          class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                          placeholder="Ajoutez des informations complémentaires pour le spécialiste..."></textarea>
            </div>

            <!-- Action Buttons -->
            <div class="flex justify-end space-x-4 pt-6 border-t border-gray-200">
                <a href="${pageContext.request.contextPath}/dashboard/consultations"
                   class="px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                    Annuler
                </a>

                <button type="submit" id="submitButton" disabled
                        class="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-400 cursor-not-allowed">
                    Envoyer la consultation
                </button>
                <button type="submit" id="enabledSubmitButton"
                        class="hidden px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                    Envoyer la consultation
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    // Show agenda when specialist is selected
    function showAgendaForSpecialist(specialistId) {
        const agendaSection = document.getElementById('agendaSection');
        const noSpecialistSelected = document.getElementById('noSpecialistSelected');
        const noAgendaAvailable = document.getElementById('noAgendaAvailable');
        const selectedAppointment = document.getElementById('selectedAppointment');

        // Hide all agenda containers first
        document.querySelectorAll('[id^="agendas-"]').forEach(el => {
            el.classList.add('hidden');
        });

        // Reset selection
        selectedAppointment.classList.add('hidden');
        document.getElementById('submitButton').classList.remove('hidden');
        document.getElementById('enabledSubmitButton').classList.add('hidden');
        document.getElementById('submitButton').disabled = true;

        if (!specialistId) {
            agendaSection.classList.remove('hidden');
            noSpecialistSelected.classList.remove('hidden');
            noAgendaAvailable.classList.add('hidden');
            return;
        }

        agendaSection.classList.remove('hidden');
        noSpecialistSelected.classList.add('hidden');

        // Show the agenda for the selected specialist
        const selectedAgendaDiv = document.getElementById('agendas-' + specialistId);
        if (selectedAgendaDiv) {
            selectedAgendaDiv.classList.remove('hidden');
            noAgendaAvailable.classList.add('hidden');
        } else {
            noAgendaAvailable.classList.remove('hidden');
        }
    }

    // Select appointment
    function selectAppointment(radio, date, startTime, endTime) {
        if (!radio.checked) return;

        const selectedAppointment = document.getElementById('selectedAppointment');
        const selectedDateTime = document.getElementById('selectedDateTime');
        const selectedConsultationDate = document.getElementById('selectedConsultationDate');
        const selectedDate = document.getElementById('selectedDate');
        const selectedTime = document.getElementById('selectedTime');

        // Format the date for display
        const dateObj = new Date(date);
        const options = {weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'};
        const formattedDate = dateObj.toLocaleDateString('fr-FR', options);

        // Update display
        selectedDateTime.textContent = formattedDate + ' de ' + startTime + ' à ' + endTime;
        selectedConsultationDate.value = date;

        // Set the hidden fields for servlet
        selectedDate.value = date;
        selectedTime.value = startTime; // Using startTime as the appointment time

        // Show selected appointment section
        selectedAppointment.classList.remove('hidden');

        // Enable submit button
        document.getElementById('submitButton').classList.add('hidden');
        document.getElementById('enabledSubmitButton').classList.remove('hidden');
    }

    // Initialize form
    document.addEventListener('DOMContentLoaded', function () {
        // Show agenda section immediately if a specialist is pre-selected
        const specialistSelect = document.getElementById('specialist');
        if (specialistSelect.value) {
            showAgendaForSpecialist(specialistSelect.value);
        }
    });
</script>
</body>
</html>