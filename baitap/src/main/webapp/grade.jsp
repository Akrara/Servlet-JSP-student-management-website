<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<html lang="vie">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <script src="https://kit.fontawesome.com/cf0c20577d.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css" />
	<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>
    <title>Student ${studentid}</title>
    <style>
    	.content:hover{
    		background-color:lightblue;
    	}
        td{
        	display:flex;
        	flex-wrap:wrap;
        	width:100%;
        	justify-content:center;
        	align-items:center;
            border:1px solid black;
        }
        th{
        	padding:0;
        	display:flex;
        	width:100%;
        	flex-wrap:wrap;
        	justify-content:center;
        	align-items:center;
            background-color:blanchedalmond;
            border-bottom:1px solid black;
        }
        tr{
        	display:flex;
        	width:100%;
        }
    </style>
</head>
<body>
	<div id="courseid1" style="display:none">${courseid }</div>
    <div id="frame" style="display:flex;width:100%;align-items:center;justify-content:center;flex-wrap:wrap">
    <div style="display:flex;width:100%;font-size:30px;justify-content:center;font-family: serif;font-weight:bold">Student ${studentid }</div>
    <button onClick="goto('')" style="font-size:30px;padding:10px;background-color:cyan;border-radius:10px;margin-top:10px;margin-bottom:25px">Go to course list</button> 
    <button onClick="goto('student')" style="font-size:30px;padding:10px;background-color:cyan;border-radius:10px;margin-top:10px;margin-bottom:25px">Go to student list</button>
    
        <div style="width:100%;border-radius:15px;border:1px solid black;overflow:hidden">
        <table id="table1" cellspacing="0" cellpadding="10px" style="max-height:500%;width:100%;display:flex;flex-wrap:wrap	">
            <thead style="width:100%;display:flex;flex-wrap:wrap">
            <tr style="height:50px;position:sticky;position:-webkit-sticky;z-index:2;top:0">
                <th>No.</th>
                <th>CourseID</th>
                <th>Course Name</th>
                <th>Grade</th>
            </tr>
            </thead>
            <tbody style="width:100%;display:flex;flex-wrap:wrap">
           	<c:set var="count" value="0" scope="page"/>
			<c:forEach var="item" items="${list }">
            	<tr class="content" style="cursor:pointer;">
            	<c:set var="count" value="${count +1 }" scope="page"/>
            	<td class="number">${count}</td>
            	<td class="id">${item.getID()}</td>
            	<td class="name">${item.getName() }</td>
            	<td class="grade">${item.getGrade()}</td>
            </tr>
            </c:forEach>
            </tbody>                                          
        </table>
        </div>
        

		
    </div>
</body>
</html>

<script>
	$('document').ready(function(){
		var table=$('#table1').DataTable();
	    $('.dataTables_filter input')
	    .off()
	    .on( 'keyup', function () {
	        table.column(2).search( this.value ).draw();
	    } );
		
	})
	function goto(des){
		window.location.href="/"+des;
	}
	
</script>