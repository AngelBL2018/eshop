<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: expert
  Date: 3/6/18
  Time: 3:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body bgcolor="#ffe4c4">

<h1 style="color: red;">Welcome ${name}</h1><br>
<br>

<c:forEach items="${productList}" var="product">
    <div style="width: 355px; height: 383px;">
        <img src="/image?fileName=${product.picUrl}" width="200px" height="200px">
        <a href="/deleteFromWhishList?productId=${product.id}" ><button style="height: 20px;height: 20px;">X</button></a>
        <br>
        <h3>${product.name}</h3><br>
        <span>${product.price}$</span><br>
        <span>${product.brand.name}</span><br>
        <span>quantity-${product.quantity}</span><br>
        <span>${product.description}</span><br>
        <a href="/cart?id=${product.id}"><button style="width: 80px;height: 40px;color: #5e5e5e">Add to Cart</button></a>

    </div>
    <hr>


</c:forEach>
</body>
</html>
