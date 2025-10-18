<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="min-h-screen bg-gray-50 py-8">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="bg-white rounded-2xl shadow-lg overflow-hidden">
            <!-- Header -->
            <div class="bg-gradient-to-r from-blue-600 to-indigo-700 px-6 py-8">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-3xl font-bold text-white mb-2">
                            Liste des tickets
                        </h1>
                        <p class="text-blue-100 text-lg">
                            Du plus récent au plus ancien
                        </p>
                    </div>
                    <div class="bg-white/10 rounded-xl p-3">
                        <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"></path>
                        </svg>
                    </div>
                </div>
            </div>

            <!-- Table -->
            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead class="bg-gray-100 border-b-2 border-gray-200">
                    <tr>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 uppercase tracking-wider">
                            ID
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 uppercase tracking-wider">
                            Patient
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 uppercase tracking-wider">
                            Date de création
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 uppercase tracking-wider">
                            Status
                        </th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                    <c:forEach var="ticket" items="${tickets}" varStatus="status">
                        <tr class="transition-colors hover:bg-gray-50 ${status.index % 2 == 0 ? 'bg-white' : 'bg-gray-50'}">
                            <td class="px-6 py-4 whitespace-nowrap">
                              <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-blue-100 text-blue-800">
                                #${ticket.id}
                              </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0 h-10 w-10 bg-gradient-to-br from-blue-500 to-indigo-600 rounded-full flex items-center justify-center">
                                      <span class="text-white font-semibold text-sm">
                                              ${ticket.patient.firstName.charAt(0)}${ticket.patient.lastName.charAt(0)}
                                      </span>
                                    </div>
                                    <div class="ml-4">
                                        <div class="text-sm font-medium text-gray-900">
                                                ${ticket.patient.firstName} ${ticket.patient.lastName}
                                        </div>
                                        <div class="text-sm text-gray-500">
                                            Patient
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900 font-medium">
                                    <fmt:formatDate value="${ticket.createdAt}" pattern="dd/MM/yyyy"/>
                                </div>
                                <div class="text-sm text-gray-500">
                                    <fmt:formatDate value="${ticket.createdAt}" pattern="HH:mm"/>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <c:choose>
                                    <c:when test="${ticket.status == 'ACTIVE'}">
                                        <span>Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>Completed</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Footer -->
            <div class="bg-gray-50 px-6 py-4 border-t border-gray-200">
                <div class="flex items-center justify-between">
                    <p class="text-sm text-gray-600">
                        Total: <span class="font-semibold">${fn:length(tickets)}</span> tickets
                    </p>
                    <p class="text-sm text-gray-600">
                        Généré le <span class="font-semibold"><fmt:formatDate value="<%= new java.util.Date() %>"
                                                                              pattern="dd/MM/yyyy à HH:mm"/></span>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>