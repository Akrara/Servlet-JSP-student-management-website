<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import="baitap.Coursecol" %>
<html lang="vie">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <script src="https://kit.fontawesome.com/cf0c20577d.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css" />
	<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>
    <title>Course ${courseid}</title>
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
    <div style="display:flex;width:100%;font-size:30px;justify-content:center;font-family: serif;font-weight:bold">Course ${courseid }</div>
    <button onClick="goto('')" style="font-size:30px;padding:10px;background-color:cyan;border-radius:10px;margin-top:10px;margin-bottom:25px">Go to course list</button> 
    <button onClick="goto('student')" style="font-size:30px;padding:10px;background-color:cyan;border-radius:10px;margin-top:10px;margin-bottom:25px">Go to student list</button>
    
        <div style="width:100%;border-radius:15px;border:1px solid black;overflow:hidden">
        <table id="table1" cellspacing="0" cellpadding="10px" style="max-height:500%;width:100%;display:flex;flex-wrap:wrap	">
            <thead style="width:100%;display:flex;flex-wrap:wrap">
            <tr style="height:50px;position:sticky;position:-webkit-sticky;z-index:2;top:0">
                <th>No.</th>
                <th>StudentID</th>
                <th>Grade</th>
            </tr>
            </thead>
            <tbody style="width:100%;display:flex;flex-wrap:wrap">
           	<c:set var="count" value="0" scope="page"/>
			<c:forEach var="item" items="${list }">
            	<tr class="content" onClick="redirect(event)" style="cursor:pointer;">
            	<c:set var="count" value="${count +1 }" scope="page"/>
            	<td class="number">${count}</td>
            	<td class="studentid">${item.getStudent()}</td>
            	<td class="grade">${item.getGrade()}</td>
            </tr>
            </c:forEach>
            </tbody>                                          
        </table>
        </div>
        
        <div style="display:flex;justify-content:center;margin-top:20px;margin-left:10px;margin-right:10px;border:1px solid black;border-radius:10px;overflow:hidden;font-size:18px">
        <form onsubmit="addrow(event)" id="addrowform">
        <div style="display:flex;justify-content:center;padding:5px;width:100%;background-color:lightskyblue;margin-bottom:10px">Add new data</div>
        <div style="padding-left:5px;padding-right:5px">
        StudentID:<input name="id" style="margin:5px">
        Grade(optional)<input name="grade" style="margin:5px">
        <button style="border-radius:10px;font-size:15px;background-color:lightskyblue;padding:5px" type="submit">Submit</button>
        </div>
        </form>
		</div>
		
		<div style="display:flex;justify-content:center;margin-top:20px;margin-left:10px;margin-right:10px;border:1px solid black;border-radius:10px;overflow:hidden;font-size:18px">
        <form onsubmit="delrow(event)" id="delrowform">
        <div style="display:flex;justify-content:center;padding:5px;width:100%;background-color:lightskyblue;margin-bottom:10px">Delete existing data</div>
        <div style="padding-left:5px;padding-right:5px">
        Number (No.):<input name="number" style="margin:5px">
        <button style="border-radius:10px;font-size:15px;background-color:lightskyblue;padding:5px" type="submit">Submit</button>
        </div>
        </form>
		</div>
		
		<div style="display:flex;justify-content:center;margin-top:20px;margin-left:10px;margin-right:10px;border:1px solid black;border-radius:10px;overflow:hidden;font-size:18px">
        <form onsubmit="editrow(event)" id="editrowform">
        <div style="display:flex;justify-content:center;padding:5px;width:100%;background-color:lightskyblue;margin-bottom:10px">Edit a row</div>
        <div style="padding-left:5px;padding-right:5px">
        Number (No.) (Will be used to locate which row to edit):<input name="number" style="margin:5px"><br>
        New StudentID:<input name="id" style="margin:5px">
        New Grade:<input name="grade" style="margin:5px">
        <button style="border-radius:10px;font-size:15px;background-color:lightskyblue;padding:5px" type="submit">Submit</button>
        </div>
        </form>
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
	        table.column(1).search( this.value ).draw();
	    } );
		
	})
	function goto(des){
		window.location.href="/"+des;
	}
	function addrow(event){
		event.preventDefault();
		var formdata=new FormData(document.forms.addrowform);
		var id1=formdata.get('id');
		var grade1=formdata.get('grade');
		if (grade1==""||grade1==null){
			grade1="-1";
		}
		if(id1==null||id1==""){
			console.log("null val");
			return false;
		}
		else{
			$.ajax({
	            url:'/course',
	            data:{
	            	id:$('#courseid1').html(),
	            	studentid:id1,
	            	grade:grade1,
	            	mode:"add"},
	            type:'POST',
	            cache:false,
	            success:function(){
	            	console.log($('#courseid1').html()+", "+id1);
	               alert("Data sent");
	               window.location.reload(); 
	            },
	            error:function(){
	              alert('Cannot send data,error');
	            }
	         })
		}
	}
	function delrow(event){
		event.preventDefault();
		var formdata=new FormData(document.forms.delrowform);
		var no1=formdata.get('number');
		if(no1==null||no1==""){
			return false;
		}
		else{
			var parentnode;
			var nodes=document.getElementsByClassName("number");
			for (var x=0;x<nodes.length;x++){
				if(nodes[x].innerHTML==no1){
					parentnode=nodes[x].parentNode;
					break;
				}
			}
			$.ajax({
	            url:'/course',
	            data:{
	            	id:$('#courseid1').html(),
	            	studentid:parentnode.children[1].innerHTML,
	            	mode:"del"},
	            type:'POST',
	            cache:false,
	            success:function(){
	               alert("Data sent");
	               window.location.reload(); 
	            },
	            error:function(){
	              alert('Cannot send data,error');
	            }
	         })
		}
	}
	function editrow(event){
		event.preventDefault();
		var formdata=new FormData(document.forms.editrowform);
		var no1=formdata.get('number');
		if(no1==null||no1==""){
			return false;
		}
		var id1=formdata.get('id');

		var grade1=formdata.get('grade');
		if (grade1==""||grade1==null){
			grade1="-1";
		}
		var id2;
		var nodes=document.getElementsByClassName("number");
		for (var x=0;x<nodes.length;x++){
			if(nodes[x].innerHTML==no1){
				id2=nodes[x].parentNode.children[1].innerHTML;
				if (id1==""||id1==null){
					id1=id2;	
				}
				break;
			}
		}
		
			$.ajax({
	            url:'/course',
	            data:{
	            	id:$('#courseid1').html(),
	            	studentid:id1,
	            	oldid:id2,
	            	grade:grade1,
	            	mode:"edit"},
	            type:'POST',
	            cache:false,
	            success:function(){
	               alert("Data sent");
	               window.location.reload(); 
	            },
	            error:function(){
	              alert('Cannot send data,error');
	            }
	         })
		
	}
	function redirect(e){
		let child=null;
		if (e.target.classList.contains("studentid")){
			child=e.target.innerHTML;
			window.location.href="/student";
		}
		else{
			child=e.target.parentNode.children[1].innerHTML;
			window.location.href="/grade?studentid="+child;
		}
	};
</script>