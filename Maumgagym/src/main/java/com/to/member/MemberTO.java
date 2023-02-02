package com.to.member;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MemberTO {
	
	int seq;
	String nickname;
	String id;
	String password;
	String name;
	String birthday;
	String phone;
	String email;
	String type;
	
	String zipcode;
	String address;
	String fulladdress;
	String referaddress;
}
