const fs = require('fs');
const path = require('path');

const templatesDir = '/Users/nguyenanhtuan/Documents/BACKEND/Kiểm thử PM/tour-booking/src/main/resources/templates';

const files = [
    'tour-detail.html',
    'order-form.html',
    'success.html'
];

for (const f of files) {
    const file = path.join(templatesDir, f);
    if (fs.existsSync(file)) {
        let html = fs.readFileSync(file, 'utf8');
        
        if (html.includes('href="/my-bookings"')) {
            console.log(f + " already has my-bookings");
            continue;
        }

        // Regex to match the login link
        const regex = /<a th:if="\${session\.user == null}" href="\/login".*?>Đăng nhập<\/a>/;
        
        if (regex.test(html)) {
            const replacement = `<a th:if="\${session.user != null}" href="/my-bookings" style="margin-right: 2rem; text-decoration: none; font-weight: 500; color: var(--dark);">Lịch sử đặt tour</a>\n            $&`;
            html = html.replace(regex, replacement);
            fs.writeFileSync(file, html);
            console.log("Updated " + f);
        } else {
            console.log("Could not find target in " + f);
        }
    }
}
