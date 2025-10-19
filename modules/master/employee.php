<?php
$pageTitle = "사원 관리";
ob_start();
?>
<div class="flex flex-col gap-6">

  <!-- 입력 폼 -->
  <form id="employeeForm" class="grid grid-cols-1 md:grid-cols-3 gap-4">
    <input type="hidden" id="id" />
    <input type="text" id="emp_name" placeholder="사원명" class="border p-2 rounded">
    <input type="text" id="department" placeholder="부서" class="border p-2 rounded">
    <input type="text" id="position" placeholder="직급" class="border p-2 rounded">
    <input type="text" id="phone" placeholder="전화번호" class="border p-2 rounded">
    <input type="email" id="email" placeholder="이메일" class="border p-2 rounded">
    <button type="button" id="saveBtn" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">저장</button>
  </form>

  <!-- 리스트 -->
  <div class="overflow-x-auto">
    <table class="min-w-full border text-sm text-left">
      <thead class="bg-gray-200">
        <tr>
          <th class="p-2">ID</th>
          <th class="p-2">사원명</th>
          <th class="p-2">부서</th>
          <th class="p-2">직급</th>
          <th class="p-2">전화번호</th>
          <th class="p-2">이메일</th>
          <th class="p-2 text-center">관리</th>
        </tr>
      </thead>
      <tbody id="dataList"></tbody>
    </table>
  </div>

  <!-- 페이지 네비게이션 -->
  <div class="flex justify-between items-center mt-4">
    <div>
      <label>표시 개수:
        <select id="limit" class="border rounded p-1">
          <option>10</option>
          <option>20</option>
          <option>30</option>
          <option>40</option>
          <option>50</option>
        </select>
      </label>
    </div>
    <div id="pagination" class="flex gap-2"></div>
  </div>
</div>

<script>
  let currentPage = 1;

  function loadList() {
    const limit = document.getElementById("limit").value;
    fetch(`/api/employees.php?action=list&page=${currentPage}&limit=${limit}`)
      .then(r => r.json())
      .then(res => {
        const tbody = document.getElementById("dataList");
        tbody.innerHTML = "";
        res.data.forEach(row => {
          tbody.innerHTML += `
          <tr class="border-b hover:bg-gray-50">
            <td class="p-2">${row.id}</td>
            <td class="p-2">${row.emp_name}</td>
            <td class="p-2">${row.department}</td>
            <td class="p-2">${row.position}</td>
            <td class="p-2">${row.phone}</td>
            <td class="p-2">${row.email}</td>
            <td class="p-2 text-center">
              <button onclick='editRow(${JSON.stringify(row)})' class="text-blue-600 hover:underline">수정</button>
              <button onclick='deleteRow(${row.id})' class="text-red-600 hover:underline ml-2">삭제</button>
            </td>
          </tr>`;
        });

        const totalPages = Math.ceil(res.total / limit);
        const nav = document.getElementById("pagination");
        nav.innerHTML = "";
        for (let i = 1; i <= totalPages; i++) {
          nav.innerHTML += `<button onclick="gotoPage(${i})" class="px-2 py-1 border rounded ${i===currentPage?'bg-blue-600 text-white':''}">${i}</button>`;
        }
      });
  }

  function gotoPage(p) {
    currentPage = p;
    loadList();
  }

  function editRow(row) {
    id.value = row.id;
    emp_name.value = row.emp_name;
    department.value = row.department;
    position.value = row.position;
    phone.value = row.phone;
    email.value = row.email;
  }

  function deleteRow(id) {
    if (!confirm("삭제하시겠습니까?")) return;
    fetch("/api/employees.php?action=delete", {
      method: "POST",
      body: new URLSearchParams({
        id
      })
    }).then(r => r.json()).then(loadList);
  }

  saveBtn.addEventListener("click", () => {
    const id = document.getElementById("id").value;
    const data = {
      id,
      emp_name: emp_name.value,
      department: department.value,
      position: position.value,
      phone: phone.value,
      email: email.value
    };
    const action = id ? "update" : "add";
    fetch(`/api/employees.php?action=${action}`, {
        method: "POST",
        body: new URLSearchParams(data)
      })
      .then(r => r.json())
      .then(res => {
        alert(res.message);
        document.getElementById("employeeForm").reset();
        loadList();
      });
  });

  loadList();
</script>

<?php
$content = ob_get_clean();
include_once "../../layouts/dashboard.php";
?>