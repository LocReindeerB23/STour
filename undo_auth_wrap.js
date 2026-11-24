const fs = require('fs');

const files = [
    '/Users/nguyenanhtuan/Documents/BACKEND/Kiểm thử PM/tour-booking/src/main/resources/templates/login.html',
    '/Users/nguyenanhtuan/Documents/BACKEND/Kiểm thử PM/tour-booking/src/main/resources/templates/register.html'
];

const oldNavbar = `    <nav class="navbar">
        <a href="/" class="logo">Tuấn Vi Vu ✈️</a>
        <div class="nav-links">
            <a href="/">Trang chủ</a>
            <a href="/tours">Danh sách Tour</a>
            <a th:if="\${session.user == null}" href="/login" style="background: var(--primary); color: white; padding: 8px 16px; border-radius: 50px;">Đăng nhập</a>
            <span th:if="\${session.user != null}" style="margin-left: 2rem; font-weight: 600;">
                Chào, <span th:text="\${session.user.fullName}"></span>! 
                <a href="/logout" style="color: #dc2626; margin-left: 10px;">Đăng xuất</a>
            </span>
        </div>
    </nav>`;

for (const file of files) {
    if (!fs.existsSync(file)) continue;
    let html = fs.readFileSync(file, 'utf8');

    // Remove the injected header
    html = html.replace(/<!-- Header-->[\s\S]*?<!-- End Header-->/, oldNavbar);

    // Remove the injected footer
    html = html.replace(/<!-- Footer-->[\s\S]*?<!-- End Box Contact-->/, '');
    
    // Remove injected scripts at the end of body
    html = html.replace(/<script src="https:\/\/unpkg\.com\/aos@2\.3\.1\/dist\/aos\.js"><\/script>[\s\S]*?<script th:src="@{\/assets\/js\/script\.js}"><\/script>/, '');

    // Remove injected stylesheets from head
    html = html.replace(/<link rel="preconnect" href="https:\/\/fonts\.googleapis\.com"\/>[\s\S]*?<link th:href="@{\/assets\/css\/terms-privacy-policy\.css}" rel="stylesheet"\/>/, '');

    fs.writeFileSync(file, html);
    console.log("Restored " + file);
}
