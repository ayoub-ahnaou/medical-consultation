<%@ include file="../layout/header.jsp" %>

<div class="container mx-auto px-4 py-8 max-w-7xl">
    <h1 class="text-3xl font-bold text-gray-800 mb-8">Consultation du Patient</h1>

    <c:choose>
        <c:when test="${not empty patient}">
            <div class="bg-white rounded-lg shadow-md p-6 mb-6 border border-gray-200">
                <h2 class="text-xl font-semibold text-gray-700 mb-4 pb-2 border-b border-gray-100">Informations du
                    patient</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <p class="text-gray-600"><strong
                                class="font-medium text-gray-800">Nom:</strong> ${patient.firstName}</p>
                        <p class="text-gray-600"><strong
                                class="font-medium text-gray-800">Prénom:</strong> ${patient.lastName}</p>
                    </div>
                    <div>
                        <p class="text-gray-600"><strong
                                class="font-medium text-gray-800">Sexe:</strong> ${patient.gender}</p>
                        <p class="text-gray-600"><strong class="font-medium text-gray-800">Date de
                            naissance:</strong> ${patient.dateOfBirth}</p>
                    </div>
                    <div>
                        <p class="text-gray-600"><strong
                                class="font-medium text-gray-800">Height:</strong> ${patient.height}</p>
                        <p class="text-gray-600"><strong
                                class="font-medium text-gray-800">Weight:</strong> ${patient.weight}</p>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-lg shadow-md p-6 border border-gray-200">
                <h2 class="text-xl font-semibold text-gray-700 mb-4 pb-2 border-b border-gray-100">Dossier médical</h2>
                <c:if test="${not empty medicalFile}">
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                        <div class="bg-gray-50 rounded-lg p-4">
                            <p class="text-sm text-gray-500">Température</p>
                            <p class="text-lg font-medium text-gray-800">${medicalFile.temperature} °C</p>
                        </div>
                        <div class="bg-gray-50 rounded-lg p-4">
                            <p class="text-sm text-gray-500">Pouls</p>
                            <p class="text-lg font-medium text-gray-800">${medicalFile.pulse} bpm</p>
                        </div>
                        <div class="bg-gray-50 rounded-lg p-4">
                            <p class="text-sm text-gray-500">Tension artérielle</p>
                            <p class="text-lg font-medium text-gray-800">${medicalFile.bloodPresure} mmHg</p>
                        </div>
                        <div class="bg-gray-50 rounded-lg p-4">
                            <p class="text-sm text-gray-500">Fréquence respiratoire</p>
                            <p class="text-lg font-medium text-gray-800">${medicalFile.respiratoryRate} cpm</p>
                        </div>
                        <div class="bg-gray-50 rounded-lg p-4">
                            <p class="text-sm text-gray-500">SpO₂</p>
                            <p class="text-lg font-medium text-gray-800">${medicalFile.oxygenSaturation}%</p>
                        </div>
                        <div class="bg-gray-50 rounded-lg p-4">
                            <p class="text-sm text-gray-500">Douleur</p>
                            <p class="text-lg font-medium text-gray-800">${medicalFile.pain}/10</p>
                        </div>
                    </div>
                </c:if>
                <c:if test="${empty medicalFile}">
                    <p class="text-gray-500 italic py-4">Aucun dossier médical trouvé.</p>
                </c:if>
            </div>
        </c:when>
        <c:otherwise>
            <div class="bg-white rounded-lg shadow-md p-6 text-center">
                <p class="text-gray-500 italic">Patient introuvable.</p>
            </div>
        </c:otherwise>
    </c:choose>

    <%-- Form --%>
    <form action="${pageContext.request.contextPath}/dashboard/consultations" method="post" class="space-y-6">
        <!-- Consultation ID (if editing existing) -->
        <input type="hidden" name="consultationId" value="${consultation.id}">

        <!-- Medical Acts Selection -->
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">
                Medical Acts (Select one or multiple)
            </label>
            <select name="medicalActs" multiple
                    class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 h-48">
                <option value="">-- No medical act selected --</option>
                <option value="1">General Consultation - $50.0</option>
                <option value="2">Specialist Consultation - $80.0</option>
                <option value="3">Blood Test - Complete Blood Count - $25.0</option>
                <option value="4">X-Ray - Chest - $45.0</option>
                <option value="5">MRI Scan - Brain - $300.0</option>
                <option value="6">CT Scan - Abdomen - $250.0</option>
                <option value="7">Ultrasound - Abdominal - $120.0</option>
                <option value="8">Vaccination - Influenza - $30.0</option>
                <option value="9">Minor Surgery - Suturing - $150.0</option>
                <option value="10">Dental Checkup and Cleaning - $60.0</option>
                <option value="11">Eye Examination - Comprehensive - $55.0</option>
                <option value="12">Physical Therapy Session - $75.0</option>
                <option value="13">ECG - Electrocardiogram - $40.0</option>
                <option value="14">Urine Analysis - $15.0</option>
                <option value="15">Allergy Testing - Skin Prick - $90.0</option>
                <option value="16">Skin Biopsy - $110.0</option>
                <option value="17">Colonoscopy - $400.0</option>
                <option value="18">Endoscopy - Upper GI - $350.0</option>
                <option value="19">Echocardiogram - $200.0</option>
                <option value="20">Bone Density Test - $85.0</option>
                <option value="21">Cardiac Stress Test - $180.0</option>
                <option value="22">Holter Monitor Installation - $95.0</option>
                <option value="23">Cardiac Catheterization - $1200.0</option>
                <option value="24">EEG - Electroencephalogram - $220.0</option>
                <option value="25">EMG - Electromyography - $190.0</option>
                <option value="26">Nerve Conduction Study - $210.0</option>
            </select>
            <p class="text-sm text-gray-500 mt-1">Hold Ctrl/Cmd to select multiple acts</p>
        </div>

        <!-- Feedback Text Area -->
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">
                Consultation Feedback & Observations
            </label>
            <textarea name="feedback" rows="6"
                      class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                      placeholder="Enter detailed feedback about the consultation, patient symptoms, observations, and recommendations..."
            ></textarea>
        </div>

        <!-- Specialist Referral -->
        <div class="border-t border-gray-200 pt-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Specialist Referral</h3>

            <div class="space-y-4">
                <div class="flex items-center">
                    <input type="checkbox" id="referToSpecialist" name="referToSpecialist"
                           class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                           onchange="toggleSpecialistSelection()">
                    <label for="referToSpecialist" class="ml-2 block text-sm text-gray-900">
                        Refer to Specialist for Second Opinion
                    </label>
                </div>

                <div id="specialistSelection" class="hidden space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            Select Specialist
                        </label>
                        <select name="specialistId"
                                class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                            <c:forEach items="${specialists}" var="specialist">
                                <option value="${specialist.id}">Dr. ${specialist.firstName} - ${specialist.speciality}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="flex justify-end space-x-4 pt-6 border-t border-gray-200">
            <button type="submit" name="action" value="complete"
                    class="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                Complete Consultation
            </button>

            <button type="submit" name="action" value="refer"
                    class="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                Send to Specialist
            </button>
        </div>
    </form>

    <script>
        function toggleSpecialistSelection() {
            const checkbox = document.getElementById('referToSpecialist');
            const specialistDiv = document.getElementById('specialistSelection');

            if (checkbox.checked) {
                specialistDiv.classList.remove('hidden');
            } else {
                specialistDiv.classList.add('hidden');
            }
        }

        // Initialize form state
        document.addEventListener('DOMContentLoaded', function() {
            toggleSpecialistSelection();

            // If there are previously selected medical acts, restore them
            const selectedActs = [<c:forEach var="act" items="${selectedActs}">"${act}",</c:forEach>];
            const selectElement = document.querySelector('select[name="medicalActs"]');

            selectedActs.forEach(actId => {
                const option = selectElement.querySelector(`option[value="${actId}"]`);
                if (option) {
                    option.selected = true;
                }
            });
        });
    </script>
</div>