<?php
include_once "../../includes/session.php";
include_once "../../includes/header.php";
include_once "../../includes/navigation.php";
?>

<main class="p-6 bg-gray-50 min-h-screen">

  <!-- 페이지 제목 -->
  <div class="mb-6">
    <h1 class="text-2xl font-bold text-gray-800">거래처 관리</h1>
    <p class="text-gray-500 text-sm mt-1">거래처 등록, 수정 및 삭제 관리</p>
  </div>

  <!-- 등록 폼 -->
  <div class="bg-white p-6 rounded-2xl shadow mb-6">
    <h2 class="text-lg font-semibold text-gray-700 mb-4">거래처 등록</h2>
    <form id="customerForm" class="grid grid-cols-1 md:grid-cols-3 gap-4">
      <div>
        <label class="block text-gray-600 mb-1">거래처명</label>
        <input type="text" id="cust_name" name="cust_name" class="w-full border-gray-300 rounded-lg p-2.5 focus:ring-blue-500 focus:border-blue-500">
      </div>
      <div>
        <label class="block text-gray-600 mb-1">대표자명</label>
        <input type="text" id="owner_name" name="owner_name" class="w-full border-gray-300 rounded-lg p-2.5 focus:ring-blue-500 focus:border-blue-500">
      </div>
      <div>
        <label class="block text-gray-600 mb-1">전화번호</label>
        <input type="text" id="phone" name="phone" class="w-full border-gray-300 rounded-lg p-2.5 focus:ring-blue-500 focus:border-blue-500">
      </div>
      <div>
        <label class="block text-gray-600 mb-1">이메일</label>
        <input type="email" id="email" name="email" class="w-full border-gray-300 rounded-lg p-2.5 focus:ring-blue-500 focus:border-blue-500">
      </div>
      <div>
        <label class="block text-gray-600 mb-1">주소</label>
        <input type="text" id="address" name="address" class="w-full border-gray-300 rounded-lg p-2.5 focus:ring-blue-500 focus:border-blue-500">
      </div>
      <div class="flex items-end">
        <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg">
          등록
        </button>
      </div>
    </form>
  </div>

  <!-- 리스트 테이블 -->
  <div class="bg-white p-6 rounded-2xl shadow">
    <div class="flex justify-between items-center mb-4">
      <h2 class="text-lg font-semibold text-gray-700">거래처 목록</h2>
      <button id="exportGoogleSheet" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700">
        Google Sheets로 내보내기
      </button>
    </div>

    <div class="overflow-x-auto">
      <table class="min-w-full border border-gray-200 text-sm">
        <thead class="bg-gray-100">
          <tr>
            <th class="px-3 py-2 border">No</th>
            <th class="px-3 py-2 border">거래처명</th>
            <th class="px-3 py-2 border">대표자명</th>
            <th class="px-3 py-2 border">전화번호</th>
            <th class="px-3 py-2 border">이메일</th>
            <th class="px-3 py-2 border">주소</th>
            <th class="px-3 py-2 border w-32">관리</th>
          </tr>
        </thead>
        <tbody id="customerTable" class="divide-y divide-gray-200">
          <!-- 데이터 로드 -->
        </tbody>
      </table>
    </div>

    <!-- 페이지네이션 -->
    <div id="pagination" class="flex justify-center items-center mt-6 space-x-2"></div>
  </div>
</main>

<script>
  $(document).ready(function() {
    let currentPage = 1;
    let rowsPerPage = 10;

    // 거래처 데이터 로드
    function loadCustomers(page = 1) {
      $.get("../../api/customers.php", {
        action: "list",
        page: page,
        limit: rowsPerPage
      }, function(res) {
        renderTable(res.data);
        setupPagination(res.total, page);
      }, "json");
    }

    // 테이블 렌더링
    function renderTable(data) {
      let html = "";
      if (data.length === 0) {
        html = `<tr><td colspan="7" class="text-center py-4 text-gray-500">데이터가 없습니다.</td></tr>`;
      } else {
        $.each(data, function(i, row) {
          // Convert Korean timestamp to formatted date
          const updatedAt = new Date(row.updated_at).toLocaleString('ko-KR');
          html += `
          <tr>
            <td class="px-3 py-2 border text-center">${row.id}</td>
            <td class="px-3 py-2 border">${row.cust_name}</td>
            <td class="px-3 py-2 border">${row.owner_name}</td>
            <td class="px-3 py-2 border">${row.phone}</td>
            <td class="px-3 py-2 border">${row.email}</td>
            <td class="px-3 py-2 border">${row.address}</td>
            <td class="px-3 py-2 border text-center">
              <button class="edit-btn text-blue-600 hover:underline mr-2" data-id="${row.id}">수정</button>
              <button class="delete-btn text-red-600 hover:underline" data-id="${row.id}">삭제</button>
            </td>
          </tr>`;
        });
      }
      $("#customerTable").html(html);
    }

    // 페이지네이션
    function setupPagination(total, currentPage) {
      let totalPages = Math.ceil(total / rowsPerPage);
      let html = "";
      for (let i = 1; i <= totalPages; i++) {
        html += `<button class="px-3 py-1 border rounded ${i === currentPage ? 'bg-blue-600 text-white' : 'bg-white text-gray-700 hover:bg-gray-100'}" data-page="${i}">${i}</button>`;
      }
      $("#pagination").html(html);
    }

    // 페이지 클릭
    $(document).on("click", "#pagination button", function() {
      let page = $(this).data("page");
      currentPage = page;
      loadCustomers(page);
    });

    // 거래처 등록
    $("#customerForm").on("submit", function(e) {
      e.preventDefault();
      $.post("../../api/customers.php", $(this).serialize() + "&action=add", function(res) {
        alert(res.message);
        loadCustomers();
        $("#customerForm")[0].reset();
      }, "json");
    });

    // 삭제
    $(document).on("click", ".delete-btn", function() {
      if (!confirm("삭제하시겠습니까?")) return;
      let id = $(this).data("id");
      $.post("../../api/customers.php", {
        action: "delete",
        id: id
      }, function(res) {
        alert(res.message);
        loadCustomers(currentPage);
      }, "json");
    });

    // ✅ Google Sheets 내보내기
    $("#exportGoogleSheet").click(function() {
      $.get("../../api/customers.php", {
        action: "list",
        page: currentPage,
        limit: rowsPerPage
      }, function(res) {
        $.ajax({
          url: "../../api/google_export.php",
          method: "POST",
          contentType: "application/json",
          data: JSON.stringify({
            sheetName: "거래처관리",
            data: res.data
          }),
          success: function(response) {
            alert(response.message || "Google Sheets로 내보내기 완료!");
          },
          error: function() {
            alert("Google Sheets로 전송 실패!");
          }
        });
      }, "json");
    });

    // 초기 로드
    loadCustomers();
  });
</script>

<?php include_once "../../includes/footer.php"; ?>