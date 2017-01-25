<%@ tag
  display-name="list-main"
  body-content="empty"
  trimDirectiveWhitespaces="true"
  description="Searches for resources and displays the results." %>


<%@ attribute name="source" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true"
    description="The directory (including subdirectories) from which the elements are read." %>

<%@ attribute name="types" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true"
    description="The type of elements, that will be used." %>

<%@ attribute name="count" type="java.lang.Integer" required="true"
    description="The amount of elements per page." %>

<%@ attribute name="formatterSettings" type="java.util.Map" required="true"
    description="A map that can hold a variety of settings that are used to configure the appearance of the list. Is usally read from the list elements content." %>

<%@ attribute name="locale" type="java.lang.String" required="true"
    description="The locale to be used." %>

<%@ attribute name="sort" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false"
    description="The sorting field from the XML content, used by the list-search tag." %>

<%@ attribute name="categories" type="org.opencms.jsp.util.CmsJspCategoryAccessBean" required="false"
    description="The categories field from the XML content, used by the list-search tag." %>

<%@ attribute name="listid" type="java.lang.String" required="false"
    description="An ID string used for this list. Enables multiple lists on one page." %>

<%@ attribute name="showfacets" type="java.lang.String" required="false"
    description="A string containing keywords that configure which filters will be shown. Multiple keyword can be used.
    Possible keywords are: [
    none,
    category,
    sort_date,
    sort_order,
    sort_title
    ]" %>

<%@ attribute name="pageUri" type="java.lang.String" required="false"
    description="The URI of the page where the list is used. Is needed for AJAX requests because of a then differing context." %>

<%@ attribute name="subsite" type="java.lang.String" required="false"
    description="The subsite the current request comes from. Is needed for AJAX requests because of a then differing context." %>

<%@ attribute name="ajaxCall" type="java.lang.Boolean" required="false"
    description="Indicates if this tag is used during an AJAX request." %>


<%@ variable name-given="search" scope="AT_END" declare="true" variable-class="org.opencms.jsp.search.result.I_CmsSearchResultWrapper"
    description="The search result given from the search tag." %>

<%@ variable name-given="searchConfig" scope="AT_END" declare="true"
    description="The search configuration string that was used by the search tag." %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>


<fmt:setLocale value="${locale}" />

<%-- ####### Search items ################ --%>

<apollo:list-search
    source="${source}"
    subsite="${subsite}"
    types="${types}"
    sort="${sort}"
    count="${count}"
    categories="${categories}"
    showexpired="${empty formatterSettings.showExpired || formatterSettings.showExpired}"
/>

<c:if test="${search.numFound > 0}">

    <%-- ####### The facet filters ######## --%>
    <c:if test="${not empty showfacets}">
        <apollo:list-facetrow
            searchresult="${search}"
            color="${color}"
            facets="${showfacets}"
        />
    </c:if>

    <%-- ####### Elements of the list ######## --%>
    <c:forEach var="result" items="${search.searchResults}" varStatus="status">
        <%-- ###### MUST add one DIV here, otherwise OpenCms edit points won't load in Ajax lists ! ###### --%>
        <c:if test="${ajaxCall}"><c:out value='<div class="list-entry">' escapeXml="false" /></c:if>
            <cms:display
                value="${result.xmlContent.filename}"
                displayFormatters="${types}"
                editable="true"
                creationSiteMap="${pageUri}"
                create="true"
                delete="true"
                >

                <c:forEach var="parameter" items="${formatterSettings}">
                     <cms:param name="${parameter.key}" value="${parameter.value}" />
                </c:forEach>

                <cms:param name="listid">${listid}</cms:param>
                <cms:param name="index">${status.index}</cms:param>
                <cms:param name="last">${status.last}</cms:param>
                <cms:param name="pageUri">${pageUri}</cms:param>
            </cms:display>
        <c:if test="${ajaxCall}"><c:out value='</div>' escapeXml="false" /></c:if>
    </c:forEach>

</c:if>