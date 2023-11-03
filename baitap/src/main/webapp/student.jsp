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
	<title>Student List</title>
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
    <div id="frame" style="display:flex;width:100%;align-items:center;justify-content:center;flex-wrap:wrap">
		<button onClick="goto('')" style="font-size:30px;padding:10px;background-color:cyan;border-radius:10px;margin-top:10px;margin-bottom:25px">Go to course list</button> 
    	<button onClick="goto('student')" style="font-size:30px;padding:10px;background-color:cyan;border-radius:10px;margin-top:10px;margin-bottom:25px">Go to student list</button>
        <div style="width:100%;border-radius:15px;border:1px solid black;overflow:hidden">
        <table id="table1" cellspacing="0" cellpadding="10px" style="max-height:500%;width:100%;display:flex;flex-wrap:wrap	">
            <thead style="width:100%;display:flex;flex-wrap:wrap">
            <tr style="height:50px;position:sticky;position:-webkit-sticky;z-index:2;top:0">
                <th>No.</th>
                <th>ID</th>
                <th>Name</th>
                <th>Grade</th>
                <th>Birthday</th>
                <th>Address</th>
                <th>Notes</th>
            </tr>
            </thead>
            <tbody style="width:100%;display:flex;flex-wrap:wrap">
           		<c:set var="count" value="0" scope="page"/>
				<c:forEach var="item" items="${list }">
	            <tr class="content" onClick="redirect(event)" style="cursor:pointer;">
	            	<c:set var="count" value="${count +1 }" scope="page"/>
	            	<td class="number">${count}</td>
	            	<td class="id">${item.getId()}</td>
	            	<td class="name">${item.getName()}</td>
	            	<td class="grade">${item.getGrade()}</td>
	            	<td class="birthday">${item.getBirthday()}</td>
	            	<td class="address">${item.getAddress() }</td>
	            	<td class="notes">${item.getNotes()}</td>
	            </tr>
	            </c:forEach>
            </tbody>
        </table>
    	</div>
    	
    	<div style="display:flex;flex-wrap:wrap;justify-content:center">
    	
   	    <div style="display:flex;justify-content:center;margin-top:20px;border:1px solid black;border-radius:10px;overflow:hidden;font-size:18px">
        <form onsubmit="addrow(event)" id="addrowform" style="display:flex;flex-wrap:wrap">
        <div style="display:flex;justify-content:center;padding:5px;width:100%;background-color:lightskyblue;margin-bottom:10px">Add new data</div>
        <div style="padding-left:5px;padding-right:5px">
        ID:<input name="id" style="margin:8px;width:90px">
        Name:<input name="name" style="margin:8px;width:200px">
        Birthday(yyyy-MM-dd format):<input name="birthday" style="margin:8px"><br>
        Address: <input name="address" style="margin:8px;width:300px">
        Notes(optional):<input name="notes" style="margin:8px">
        <button style="border-radius:10px;font-size:18px;background-color:lightskyblue;padding:5px" type="submit">Submit</button>
        </div>
        </form>
		</div>
		
		<div style="display:flex;margin-top:20px;border:1px solid black;border-radius:10px;overflow:hidden;font-size:18px">
        <form onsubmit="delrow(event)" id="delrowform" style="display:flex;flex-wrap:wrap;justify-content:center">
        <div style="display:flex;justify-content:center;padding:5px;width:100%;background-color:lightskyblue;margin-bottom:10px">Delete existing data</div>
        <div style="padding-left:5px;padding-right:5px">
        Number (No.):<input name="number" style="margin:5px">
        <button style="border-radius:10px;font-size:18px;background-color:lightskyblue;padding:5px" type="submit">Submit</button>
        </div>
        </form>
		</div>
		
		<div style="display:flex;justify-content:stretch;margin-top:20px;border:1px solid black;border-radius:10px;overflow:hidden;font-size:18px">
        <form onsubmit="editrow(event)" id="editrowform" style="display:flex;flex-wrap:wrap;justify-content:center">
        <div style="display:flex;justify-content:center;padding:5px;width:100%;background-color:lightskyblue;margin-bottom:10px">Edit a row</div>
        <div style="padding-left:5px;padding-right:5px">
        Number (No.) (Will be used to locate which row to edit):<input name="number" style="margin:5px">
        New ID:<input name="id" style="margin:5px;width:90px">
        New Name:<input name="name" style="margin:5px">
        New Birthday:<input name="birthday" style="margin:5px">
        New Address:<input name="address" style="margin:5px;width:300px">
        New Notes:<input name="notes" style="margin:5px">
        <button style="border-radius:10px;font-size:18px;background-color:lightskyblue;padding:5px" type="submit">Submit</button>
        </div>
        </form>
		</div>
		
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
	function redirect(e){
		let child=null;
		if(e.target.classList.contains("id")){
			child=e.target.innerHTML;
		}
		else if (e.target.classList.contains("content")){
			child=e.target.children[1].innerHTML;
		}
		else{
			child=e.target.parentNode.children[1].innerHTML;
		}
		window.location.href="/grade?studentid="+child;
	}
	function addrow(event){
		event.preventDefault();
		var formdata=new FormData(document.forms.addrowform);
		var id1=formdata.get('id');
		var name1=formdata.get('name');
		var birthday1=formdata.get('birthday');
		var address1=formdata.get('address');
		var notes1=formdata.get('notes');
		if((id1==null||id1=="")||(name1==null||name1=="")||(birthday1==null||birthday1=="")
				||(address1==null||address1=="")){
			console.log("null val");
			return false;
		}
		else{
			$.ajax({
	            url:'/student',
	            data:{
	            	id:id1,
	            	name:name1,
	            	birthday:birthday1,
	            	address:address1,
	            	notes:notes1,
	            	mode:"add"},
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
	            url:'/student',
	            data:{
	            	id:parentnode.children[1].innerHTML,
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
		var name1=formdata.get('name');
		var birthday1=formdata.get('birthday');
		var address1=formdata.get('address');
		var notes1=formdata.get('notes');
		var id2;
		var nodes=document.getElementsByClassName("number");
		var num=0;
		for (var x=0;x<nodes.length;x++){
			if(nodes[x].innerHTML==no1){
				num=x;
				id2=nodes[x].parentNode.children[1].innerHTML;
				break;
			}
		}
		console.log("ok here");
		if(id1==null|id1==""){id1=id2}
		if(name1==null||name1==""){name1=nodes[num].parentNode.children[2].innerHTML}
		if(birthday1==null||birthday1==""){birthday1=nodes[num].parentNode.children[4].innerHTML}
		if(address1==null||address1==""){address1=nodes[num].parentNode.children[5].innerHTML}
		console.log("ok here");
			$.ajax({
	            url:'/student',
	            data:{id:id1,
	            	oldid:id2,
	            	name:name1,
	            	birthday:birthday1,
	            	address:address1,
	            	notes:notes1,
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
</script>