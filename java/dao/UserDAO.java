package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import dto.UserDTO;
import util.DBConnection;

public class UserDAO {

	// 로그인 체크: 1=성공, 0=비밀번호불일치, -1=아이디없음, -2=DB오류
	public int login(String username, String password) {
		String sql = "SELECT password FROM users WHERE username = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, username);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				if (rs.getString("password").equals(password)) {
					return 1; // 로그인 성공
				} else {
					return 0; // 비밀번호 불일치
				}
			}
			return -1; // 아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // DB 오류
	}

	// 유저 권한 및 정보 가져오기 (세션 저장용)
	public UserDTO getUser(String username) {
        // [수정] 모든 컬럼 조회
        String sql = "SELECT * FROM users WHERE username = ?";
        UserDTO user = null;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                user = new UserDTO();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setBirthdate(rs.getDate("birthdate"));
                user.setGender(rs.getString("gender"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone")); // [필수] 전화번호
                user.setZipcode(rs.getString("zipcode")); // [필수] 우편번호
                user.setAddress(rs.getString("address")); // [필수] 주소
                user.setAddressDetail(rs.getString("address_detail")); // [필수] 상세주소
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getDate("created_at"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

	public int getUserPK(String username) {
		String sql = "SELECT user_id FROM users WHERE username = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, username);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt("user_id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 찾지 못함
	}

	// 회원가입
	public int join(UserDTO user) {
		String sql = "INSERT INTO users (user_id, username, password, name, email, phone, address, role) "
				+ "VALUES (seq_user_id.NEXTVAL, ?, ?, ?, ?, ?, ?, 'USER')";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getEmail());
			pstmt.setString(5, user.getPhone());
			pstmt.setString(6, user.getAddress());

			return pstmt.executeUpdate(); // 1이면 성공

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 실패
	}

	// 1. 아이디 중복 확인
	public int checkDuplicate(String username) {
		String sql = "SELECT username FROM users WHERE username = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, username);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return 1; // 이미 존재함 (사용 불가)
			}
			return 0; // 존재하지 않음 (사용 가능)
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}

	// 2. 아이디 찾기 (이름 + 핸드폰번호)
	public String findId(String name, String phone) {
		String sql = "SELECT username FROM users WHERE name = ? AND phone = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, name);
			pstmt.setString(2, phone);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString("username");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 못 찾음
	}

	// 3. 비밀번호 찾기 (아이디 + 핸드폰번호) -> 실제 서비스에선 이메일 발송이 원칙이나, 요청대로 비밀번호 반환으로 구현
	public String findPw(String username, String phone) {
		String sql = "SELECT password FROM users WHERE username = ? AND phone = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, username);
			pstmt.setString(2, phone);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString("password");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 못 찾음
	}
	
	public int updateUser(UserDTO user) {
        // 비밀번호 변경 여부에 따라 쿼리가 달라질 수 있음
        // 여기서는 편의상 비밀번호가 입력된 경우만 업데이트하는 로직을 사용하거나,
        // Controller(Action)에서 분기 처리 후 넘겨주는 것이 좋음.
        // 하지만 가장 간단하게는, 비밀번호가 null/빈문자열이면 기존 비번 유지 로직을 SQL에서 처리할 수도 있음.
        // 예: NVL(?, password) -> 하지만 보안상 입력값에 따라 분기하는게 나음.
        
        String sql = "UPDATE users SET name=?, birthdate=?, gender=?, email=?, phone=?, zipcode=?, address=?, address_detail=? ";
        
        // 비밀번호가 있는 경우에만 업데이트 쿼리에 추가
        if(user.getPassword() != null && !user.getPassword().isEmpty()) {
            sql += ", password=? ";
        }
        
        sql += "WHERE username=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            int idx = 1;
            pstmt.setString(idx++, user.getName());
            pstmt.setDate(idx++, user.getBirthdate());
            pstmt.setString(idx++, user.getGender());
            pstmt.setString(idx++, user.getEmail());
            pstmt.setString(idx++, user.getPhone());
            pstmt.setString(idx++, user.getZipcode());
            pstmt.setString(idx++, user.getAddress());
            pstmt.setString(idx++, user.getAddressDetail());
            
            if(user.getPassword() != null && !user.getPassword().isEmpty()) {
                pstmt.setString(idx++, user.getPassword());
            }
            
            pstmt.setString(idx++, user.getUsername()); // WHERE 절
            
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}