<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.yowits.banbu.distrib.common.utils.Constants"%>
<%@page import="com.yowits.banbu.distrib.common.utils.StringUtil"%>

<% if(StringUtil.isNotNullOrEmpty(Constants.BAIDU_STATISTICS_TOKEN)) {%>
	<script>
		var _hmt = _hmt || [];
		(function() {
		  var hm = document.createElement("script");
		  hm.src = "//hm.baidu.com/hm.js?" + "<%=Constants.BAIDU_STATISTICS_TOKEN%>";
		  var s = document.getElementsByTagName("script")[0]; 
		  s.parentNode.insertBefore(hm, s);
		})();
	</script>
<%} %>   