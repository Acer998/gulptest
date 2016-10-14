<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.yowits.banbu.distrib.common.utils.SessionAttributes"%>
<%@ page import="com.yowits.banbu.distrib.common.enums.AccountTypeEnum"%>

<%
	Object accountType = request.getSession().getAttribute(SessionAttributes.ACCOUNT_TYPE);
%>

<!-- 左侧公共导航栏 -->
<nav class="navbar-default navbar-static-side" role="navigation">
	<div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto; height: 100%;">
		<div class="sidebar-collapse" style="overflow: hidden; width: auto; height: 100%;">
			<ul class="nav metismenu" id="side-menu">
				<li class="nav-profile">
					<div class="image">
						<a href="javascript:;"><img id="companyAccountPhoto" src="/resources/img/person2.png"></a>
					</div>
					<div class="info">
						<span id="menuName" style="visibility: hidden;"></span>
						<!-- <small id="post"></small> -->
					</div>
				</li>
				<!--<li class="nav-header">导航</li>-->
			 	<%
			 		if(AccountTypeEnum.RECOMMERDER.value.equals(accountType)){
			 	%>
			 	<li class="has-sub">
					<a href="/rest/recmder/home">
						<i class="fa fa-home fa-lg"></i> <span class="nav-label">个人信息</span>
					</a>
				</li>
				<li class="has-sub">
					<a href="/rest/recmder/goodsExchangedList">
						<i class="fa fa-gift fa-lg"></i> <span class="nav-label">积分兑换</span>
					</a>
				</li>	
			 	
			 	<%
			 		} else if(AccountTypeEnum.MANAGER.value.equals(accountType) || AccountTypeEnum.CUSTOMER_SERVICE.value.equals(accountType)){
			 	%>
				<li class="has-sub">
					<a href="/rest/admin/findRecmderStatPage">
						<i class="fa fa-file-text fa-lg"></i> <span class="nav-label">推荐管理</span>
						<span class="fa arrow"></span>
					</a>
					<ul class="nav nav-second-level collapse sub-menu">
						<li><a href="/rest/admin/findRecmderStatPage">推荐人列表</a></li>
						<li><a href="/rest/admin/recmderCompanyList">推荐公司列表</a></li>
						<li><a href="/rest/admin/integralRecord">积分记录</a></li>
					</ul>
				</li>
			 	<li class="has-sub">
					<a href="/rest/admin/exchangedRecord">
						<i class="fa fa-gift fa-lg"></i> <span class="nav-label">兑换管理</span>
						<span class="fa arrow"></span>
					</a>
					<ul class="nav nav-second-level collapse sub-menu">
						<!--<li><a href="javascript:;">兑换物品维护</a></li>-->
						<li><a href="/rest/admin/exchangedRecord">兑换记录</a></li>
					</ul>
				</li>

			 	<%
			 		}
			 	%>
				
				<li class="has-sub">
					<a href="/rest/logout">
						<i class="fa fa-sign-out fa-lg"></i> <span class="nav-label">注销登录</span>
					</a>
				</li>
			</ul>
		</div>
	</div>
</nav>