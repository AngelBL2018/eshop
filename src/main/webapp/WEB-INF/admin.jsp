<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body bgcolor="#bdb76b">

<div style="width: 1200px;height: 1000px;">
    <div style="width: 30%;height: 500px;float: left;margin-left:5px;background-color: #2a6496 "><h1
            style="color: white">Add Category</h1>
        <spring:form modelAttribute="category" method="post" action="/addCategory">
            <spring:label path="name">Name</spring:label>
            <spring:input path="name" type="text"/><br>
            <input type="submit" value="Add">
        </spring:form>


    </div>


    <div style="width: 30%;height: 500px;float: left;margin-left:5px;background-color: #2a6496 "><h1
            style="color: white">Add Brand</h1>


        <spring:form modelAttribute="brand" method="post" action="/addBrand">
            <spring:label path="name">Name</spring:label>
            <spring:input path="name" type="text"/><br>
            <input type="submit" value="Add">
        </spring:form>


    </div>

    <div style="width: 30%;height: 500px;float: left;margin-left:5px;background-color: #2a6496 "><h1
            style="color: white">Add Product</h1>


        <spring:form modelAttribute="product" method="post" action="/addProduct" enctype="multipart/form-data">
            <spring:label path="name">Name</spring:label>
            <spring:input path="name" type="text"/><br>
            <spring:label path="description">Description</spring:label>
            <spring:textarea path="description"></spring:textarea><br>
            <spring:label path="price">Price</spring:label>
            <spring:input path="price" type="text"/><br>
            <spring:label path="quantity">Quantity</spring:label>
            <spring:input path="quantity" type="text"/><br>
            <spring:label path="category">Category</spring:label>
            <spring:select path="category" items="${categoryList}" itemLabel="name"></spring:select><br>
            <spring:label path="brand">Brand</spring:label>
            <spring:select path="brand" items="${brandList}" itemLabel="name"></spring:select><br>
            <input type="file" name="picture"><br>

            <input type="submit" value="Add">
        </spring:form>

    </div>
<a href="/">Home</a>

</div>

</body>
</html>
