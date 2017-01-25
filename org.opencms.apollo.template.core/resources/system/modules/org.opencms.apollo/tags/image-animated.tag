<%@ tag
    display-name="image-animated"
    body-content="scriptless"
    trimDirectiveWhitespaces="true"
    description="Display a responsive image with optional Ken Burns and / or shadow animation effects." %>
    <%-- See https://en.wikipedia.org/wiki/Ken_Burns" --%>


<%@ attribute name="image" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true"
    description="The image to format. Must be a generic Apollo nested image content."%>

<%@ attribute name="cssclass" type="java.lang.String" required="false"
    description="CSS class added to the div tag surrounding the image."%>

<%@ attribute name="addcssclass" type="java.lang.String" required="false"
    description="CSS class added directly to the anmiated div tag surrounding the image and the text."%>

<%@ attribute name="cssimage" type="java.lang.String" required="false"
    description="CSS class added directly to the generated image tag."%>

<%@ attribute name="attr" type="java.lang.String" required="false"
    description="Attribute added directly to the generated image tag."%>

<%@ attribute name="test" type="java.lang.String" required="false"
    description="Can be used to defer the decision to actually create the markup around the body to the calling element.
    If not set or 'true', the markup from this tag is generated around the body of the tag.
    Otherwise everything is ignored and just the body of the tag is returned. "%>


<%-- ####### These variables are actually set in the apollo:image-vars tag included ####### --%>
<%@ variable name-given="imageLink" declare="true" %>
<%@ variable name-given="imageUnscaledLink" declare="true" %>
<%@ variable name-given="imageCopyright" declare="true" %>
<%@ variable name-given="imageTitle" declare="true" %>
<%@ variable name-given="imageTitleCopyright" declare="true" %>


<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>


<c:if test="${image.isSet}">
<apollo:image-vars image="${image}">

<c:if test="${(not empty imageLink) and (empty test or test)}">
<c:set var="imagefound">true</c:set>

<%-- ####### Animated image ####### --%>

<div class="ap-image ${cssclass}">

    <div class="animated-box ${addcssclass}">
        <div  ${image.value.Image.imageDndAttr} class="image-outer-box">
            <img
                <cms:img
                    src="${imageLink}"
                    partialTag="true"
                />
                class="img-responsive image-inner-box ${cssimage}"
                alt="${imageTitleCopyright}"
                title="${imageTitleCopyright}"
                ${attr}
            >
        </div>

        <%-- ####### JSP body inserted here ######## --%>
        <jsp:doBody/>
        <%-- ####### /JSP body inserted here ######## --%>

    </div>
</div>

</c:if>

</apollo:image-vars>
</c:if>

<c:if test="${empty imagefound}">

    <c:if test="${empty test or test}">
        <fmt:setLocale value="${cms.locale}" />
        <cms:bundle basename="org.opencms.apollo.template.schemas.section">
            <div class="alert">
                <fmt:message key="apollo.section.message.noimage" />
            </div>
        </cms:bundle>
    </c:if>

    <%-- ####### JSP body inserted here ######## --%>
    <jsp:doBody/>
    <%-- ####### /JSP body inserted here ######## --%>
</c:if>

