<%@ tag 
    display-name="list-search"
    body-content="scriptless"
    trimDirectiveWhitespaces="true" 
    description="Shows an image which enlarges on click." %>

<%@ attribute name="setting" type="java.util.Map" required="true" %>
<%@ attribute name="image" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="headline" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="content" type="org.opencms.jsp.util.CmsJspContentAccessBean" required="true" %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<c:if test="${image.isSet}">

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.messages">
<apollo:image-vars image="${image}">

<c:if test="${not empty imageLink}">

<div class="ap-img ${setting.istyle}">

	<div class="ap-img-pic">

		<a
			data-gallery="true"
			class="zoom"
			data-size="${cms.vfs.property[imageLink]['image.size']}"
			href="<cms:link>${imageLink}</cms:link>"
			<c:if test="${not empty imageTitleCopyright}">title="${imageTitleCopyright}"</c:if>
			data-rel="fancybox-button-${cms.element.instanceId}"
			id="fancyboxzoom${cms.element.instanceId}">
			
			<span class="zoom-overlay">
                    <span ${content.imageDnd[image.value.Image.path]}>
                        <img
                            src="<cms:link>${imageLink}</cms:link>"
                            class="img-responsive ${cms.element.setting.ieffect != 'none' ? cms.element.setting.ieffect : ''}"
                            <c:if test="${not empty imageTitleCopyright}">
                                alt="${imageTitleCopyright}"
                                title="${imageTitleCopyright}"
                            </c:if>
                        />
                    </span>
					<%-- ####### zoom icon cancels out shadow and border, only rounded corners remain ######## --%>
                    <span class="zoom-icon ${cms.element.setting.ieffect != 'none' ? cms.element.setting.ieffect : ''}" style="box-shadow: none; border: 0;">
                        <i class="fa fa-search"></i>
                    </span>
                </span>
			
		</a>
		
	</div>
		
	<%-- ####### Show copyright if enabled ######## --%>
	<c:if test="${fn:contains(setting.itext.value, 'copy') && image.value.Copyright.isSet}">
		<div class="info">
			<p class="copyright"><i>${imageCopyright}</i></p>
		</div>
	</c:if>
	
	<c:if test="${setting.itext.value != 'none'}">
			<div class="ap-img-txt">
			<c:if test="${fn:contains(setting.itext.value, 'title')}">
					<c:choose>
							<c:when	test="${image.value.Title.isSet}">
									<div class="ap-img-title"><span ${image.rdfa.Title}>${image.value.Title}</span></div>
							</c:when>
							<c:when	test="${headline.isSet}">
									<div class="ap-img-title"><span ${headline.rdfaAttr}>${headline}</span></div>
							</c:when>
					</c:choose>
			</c:if>
			<c:if test="${fn:contains(setting.itext.value, 'desc') && image.value.Description.isSet}">
					<div class="ap-img-desc"><span ${image.rdfa.Description}>${image.value.Description}</span></div>
			</c:if>
			</div>
	</c:if>
	
</div>

</c:if>

</apollo:image-vars>
</cms:bundle>

</c:if>