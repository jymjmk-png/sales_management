<?php
$pageTitle = "제품 관리";
ob_start();
?>
<div class="flex flex-col gap-6">

  <!-- 제품 입력 폼 -->
  <form id="productForm" class="grid grid-cols-1 md:grid-cols-4 gap-4">
    <input type="hidden" id="id" />
    <input type="text" id="product_name" placeholder="제품명" class="border p-2 rounded">
    <input type="text" id="category" placeholder="분류" class="border p-2 rounded">
    <input type="number" id="price" placeholder="단가" class="border p-2 rounded">
    <input type="number" id="stock" placeholder="재고수량" class="border p-2 rounded">
    <button type="button" id="saveBtn" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">저장</button>
  </form>

  <!-- 리스트 테이블 -->
  <div class="overflow-x-auto">
    <table class="min-w-full border text-sm text-left">
      <thead class="bg-gray-200">
        <tr>
          <th class="p-2">ID</th>
          <th class="p-2">제품명</th>
          <th class="p-2">분류</th>
          <th class="p-2">단가</th>
          <th class="p-2">재고</th>
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
    fetch(`/api/products.php?action=list&page=${currentPage}&limit=${limit}`)
      .then(r => r.json())
      .then(res => {
        const tbody = document.getElementById("dataList");
        tbody.innerHTML = "";
        res.data.forEach(row => {
          tbody.innerHTML += `
          <tr class="border-b hover:bg-gray-50">
            <td class="p-2">${row.id}</td>
            <td class="p-2">${row.product_name}</td>
            <td class="p-2">${row.category}</td>
            <td class="p-2 text-right">${Number(row.price).toLocaleString()}</td>
            <td class="p-2 text-right">${row.stock}</td>
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
    document.getElementById("id").value = row.id;
    document.getElementById("product_name").value = row.product_name;
    document.getElementById("category").value = row.category;
    document.getElementById("price").value = row.price;
    document.getElementById("stock").value = row.stock;
  }

  function deleteRow(id) {
    if (!confirm("삭제하시겠습니까?")) return;
    fetch("/api/products.php?action=delete", {
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
      product_name: product_name.value,
      category: category.value,
      price: price.value,
      stock: stock.value
    };
    const action = id ? "update" : "add";
    fetch(`/api/products.php?action=${action}`, {
      method: "POST",
      body: new URLSearchParams(data)
    }).then(r => r.json()).then(res => {
      alert(res.message);
      document.getElementById("productForm").reset();
      loadList();
    });
  });

  loadList();
</script>

<?php
$content = ob_get_clean();
include_once "../../layouts/dashboard.php";
?>