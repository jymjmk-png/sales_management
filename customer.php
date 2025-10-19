<?php
$pageTitle = "거래처 관리";
ob_start();
?>
<div class="flex flex-col gap-6">

  <!-- 입력 폼 -->
  <form id="customerForm" class="grid grid-cols-1 md:grid-cols-3 gap-4">
    <input type="hidden" id="id" />
    <input type="text" id="cust_name" placeholder="거래처명" class="border p-2 rounded">
    <input type="text" id="owner_name" placeholder="대표자명" class="border p-2 rounded">
    <input type="text" id="phone" placeholder="전화번호" class="border p-2 rounded">
    <input type="email" id="email" placeholder="이메일" class="border p-2 rounded">
    <input type="text" id="address" placeholder="주소" class="border p-2 rounded">
    <button type="button" id="saveBtn" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">저장</button>
  </form>

  <!-- 리스트 테이블 -->
  <div class="overflow-x-auto">
    <table class="min-w-full border text-sm text-left">
      <thead class="bg-gray-200">
        <tr>
          <th class="p-2">ID</th>
          <th class="p-2">거래처명</th>
          <th class="p-2">대표자</th>
          <th class="p-2">전화번호</th>
          <th class="p-2">이메일</th>
          <th class="p-2">주소</th>
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
    fetch(`/api/customers.php?action=list&page=${currentPage}&limit=${limit}`)
      .then(r => r.json())
      .then(res => {
        const tbody = document.getElementById("dataList");
        tbody.innerHTML = "";
        res.data.forEach(row => {
          tbody.innerHTML += `
          <tr class="border-b hover:bg-gray-50">
            <td class="p-2">${row.id}</td>
            <td class="p-2">${row.cust_name}</td>
            <td class="p-2">${row.owner_name}</td>
            <td class="p-2">${row.phone}</td>
            <td class="p-2">${row.email}</td>
            <td class="p-2">${row.address}</td>
            <td class="p-2 text-center">
              <button onclick='editRow(${JSON.stringify(row)})' class="text-blue-600 hover:underline">수정</button>
              <button onclick='deleteRow(${row.id})' class="text-red-600 hover:underline ml-2">삭제</button>
            </td>
          </tr>
        `;
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
    document.getElementById("id").value = row.id;
    document.getElementById("cust_name").value = row.cust_name;
    document.getElementById("owner_name").value = row.owner_name;
    document.getElementById("phone").value = row.phone;
    document.getElementById("email").value = row.email;
    document.getElementById("address").value = row.address;
  }

  function deleteRow(id) {
    if (!confirm("삭제하시겠습니까?")) return;
    fetch("/api/customers.php?action=delete", {
      method: "POST",
      body: new URLSearchParams({
        id
      })
    }).then(r => r.json()).then(loadList);
  }

  document.getElementById("saveBtn").addEventListener("click", () => {
    const id = document.getElementById("id").value;
    const data = {
      id,
      cust_name: cust_name.value,
      owner_name: owner_name.value,
      phone: phone.value,
      email: email.value,
      address: address.value
    };
    const action = id ? "update" : "add";

    fetch(`/api/customers.php?action=${action}`, {
      method: "POST",
      body: new URLSearchParams(data)
    }).then(r => r.json()).then(res => {
      alert(res.message);
      document.getElementById("customerForm").reset();
      loadList();
    });
  });

  loadList();
</script>
<?php
$content = ob_get_clean();
include_once "./layouts/dashboard.php";
?>