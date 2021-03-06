<%@ tag
    display-name="list-pagination"
    body-content="empty"
    trimDirectiveWhitespaces="true"
    description="Generates a pagination based on search results."%>


<%@ attribute name="search" type="org.opencms.jsp.search.result.I_CmsSearchResultWrapper" required="true"
    description="Contains the search result data that was generated by the search tag."%>

<%@ attribute name="onclickAction" type="java.lang.String" required="true"
    description="The on click action string that reloads the list. It has to contain a $(LINK) macro that
    is replaced with the actual link calculated for the individual pages.
    This is a workaround to use the pagination tag for the list as well as the search result. "%>

<%@ attribute name="singleStep" type="java.lang.Boolean" required="false"
    description="Selects if single step next / previous awwows are shown."%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:if test="${search.numFound > 0}">
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.list.messages">

    <c:set var="pagination" value="${search.controller.pagination}" />
    <%-- show pagination if it should be given and if it's really necessary --%>
    <c:if test="${not empty pagination && search.numPages > 1}">
        <div class="list-append-position" data-dynamic="false" >
            <ul class="pagination">
                <c:if test="${pagination.state.currentPage != 1}">
                    <c:set var="firstPage">1</c:set>
                    <li ${pagination.state.currentPage > 1 ? "" : "class='disabled'"}>
                        <a href='javascript:void(0)'
                            onclick='${fn:replace(onclickAction, "$(LINK)", search.stateParameters.setPage[firstPage])}'
                            title='<fmt:message key="pagination.first.title"/>'
                        >
                            <span class="fa fa-${singleStep ? 'fast' : 'step'}-backward" aria-hidden="true"></span>
                        </a>
                    </li>
                    <c:if test="${singleStep}">
                        <c:set var="previousPage">${pagination.state.currentPage > 1 ? pagination.state.currentPage - 1 : 1}</c:set>
                        <li ${pagination.state.currentPage > 1 ? "" : "class='disabled'"}>
                            <a href='javascript:void(0)'
                                onclick='${fn:replace(onclickAction, "$(LINK)", search.stateParameters.setPage[previousPage])}'
                                title='<fmt:message key="pagination.previous.title"/>'
                            >
                                <span class="fa fa-step-backward" aria-hidden="true"></span>
                            </a>
                        </li>
                    </c:if>
                </c:if>
                <c:forEach var="page" begin="${search.pageNavFirst}" end="${search.pageNavLast}">
                    <c:set var="pageNr">${page}</c:set>
                    <li ${pagination.state.currentPage eq page ? "class='active'" : ""}>
                        <a href='javascript:void(0)'
                            onclick='${fn:replace(onclickAction, "$(LINK)", search.stateParameters.setPage[pageNr])}'
                            title='<fmt:message key="pagination.page"><fmt:param>${pageNr}</fmt:param></fmt:message>'
                        >
                            <span class="number">${pageNr}</span>
                        </a>
                    </li>
                </c:forEach>
                <c:set var="pages">${search.numPages}</c:set>
                <c:set var="next">${pagination.state.currentPage < search.numPages ? pagination.state.currentPage + 1 : pagination.state.currentPage}</c:set>
                <c:if test="${pagination.state.currentPage < search.numPages}">
                    <c:if test="${singleStep}">
                        <li ${pagination.state.currentPage >= search.numPages ? "class='disabled'" : ""}>
                            <a href='javascript:void(0)'
                                onclick='${fn:replace(onclickAction, "$(LINK)", search.stateParameters.setPage[next])}'
                                title='<fmt:message key="pagination.next.title"/>'
                            >
                                 <span class="fa fa-step-forward" aria-hidden="true"></span>
                            </a>
                        </li>
                    </c:if>
                    <li ${pagination.state.currentPage >= search.numPages ? "class='disabled'" : ""}>
                        <a href='javascript:void(0)'
                            onclick='${fn:replace(onclickAction, "$(LINK)", search.stateParameters.setPage[pages])}'
                            title='<fmt:message key="pagination.last.title"/>'
                        >
                             <span class="fa fa-${singleStep ? 'fast' : 'step'}-forward" aria-hidden="true"></span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </div>
    </c:if>

</cms:bundle>
</c:if>
