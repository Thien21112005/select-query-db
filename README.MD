# EmailListWebApp - Ứng Dụng Web Java Cơ Bản

## Tổng Quan
Đây là ứng dụng web Java đơn giản sử dụng Maven, với servlet (`SqlGatewayServlet`) để thực thi các câu lệnh SQL trên cơ sở dữ liệu MySQL. Kết quả sẽ được forward đến `index.jsp` để hiển thị. Ứng dụng được container hóa bằng Docker để dễ deploy lên Render.com.

### Tính Năng
- Servlet xử lý truy vấn SQL: SELECT, INSERT, UPDATE, DELETE.
- Sử dụng environment variables cho config database (DB_URL, DB_USERNAME, DB_PASSWORD).
- Build multi-stage Docker cho image production-ready.

## Yêu Cầu
- Java 17 (JDK)
- Maven 3.8+
- MySQL server (local cho dev, hoặc MySQL trên Render cho production)
- Docker (để container hóa)
- IntelliJ IDEA (tùy chọn, cho phát triển)
- Tài khoản Render.com (để deploy)

## Cấu Trúc Project
EmailListWebApp/
├── Dockerfile          # File build Docker
├── pom.xml             # Config Maven
├── .gitignore          # Quy tắc ignore Git
├── .dockerignore       # Quy tắc ignore Docker
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── murach/sql/
│   │   │       ├── SqlGatewayServlet.java  # Servlet chính
│   │   │       ├── DBUtil.java            # Utility kết nối DB
│   │   │       └── SQLUtil.java           # Utility tạo bảng HTML từ ResultSet
│   │   └── webapp/
│   │       ├── index.jsp                  # JSP hiển thị kết quả
│   │       ├── styles/                    # File CSS (nếu có)
│   │       └── WEB-INF/                   # Config web (web.xml nếu cần)
│   └── test/                              # Unit test (nếu có)
└── target/                                # Output build (ignore)


## Hướng Dẫn Setup Và Chạy Local
1. **Clone repo**:
git clone <url-repo-cua-ban>
   cd EmailListWebApp
2. **Config Environment Variables** (cho dev local):
- Trong IntelliJ: Run > Edit Configurations > Tomcat > Environment variables.
- Thêm:
    - `DB_URL=jdbc:mysql://localhost:3306/database01?useSSL=false&serverTimezone=UTC`
    - `DB_USERNAME=root`
    - `DB_PASSWORD=mat-khau-cua-ban`

3. **Build project**: mvn clean package
4. - Tạo file `target/EmailListWebApp.war`.

4. **Chạy với Tomcat trong IntelliJ**:
- Thêm config Tomcat.
- Deploy WAR.
- Truy cập: http://localhost:8080/
- POST đến `/sqlGateway` với param `sqlStatement` (qua form hoặc Postman).

5. **Test Database**:
- Đảm bảo MySQL chạy và DB `database01` tồn tại.

## Build Và Chạy Docker
1. **Build image Docker**: docker build -t email-list-web-app .
2. **Chạy container local**:
   docker run -p 8080:8080
   -e DB_URL="jdbc:mysql://host.docker.internal:3306/database01?useSSL=false&serverTimezone=UTC"
   -e DB_USERNAME="root"
   -e DB_PASSWORD="mat-khau-cua-ban"
   email-list-web-app
- Truy cập: http://localhost:8080/

## Deploy Lên Render.com
1. **Tạo Database trên Render** (MySQL):
- New > Database > MySQL.
- Lưu host, username, password để set env vars.

2. **Deploy Web Service**:
- New > Web Service > Kết nối repo Git.
- Runtime: Docker.
- Thêm env vars: DB_URL, DB_USERNAME, DB_PASSWORD (sử dụng chi tiết từ DB Render).
- Deploy.

3. **Truy Cập**: Sử dụng URL từ Render.

## Lưu Ý
- **Bảo Mật**: Không hardcode credentials; luôn dùng env vars.
- **Cải Tiến**: Thêm connection pooling (ví dụ HikariCP) cho production.
- **License**: MIT (hoặc tùy chọn của bạn).

Nếu có vấn đề, mở issue trên GitHub hoặc liên hệ huyalex009@gmail.com.