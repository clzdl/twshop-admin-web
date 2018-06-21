package com.twshop.adminweb.common.auth;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.base.auth.token.AbstractUserToken;
import com.base.auth.token.AbstractUserTokenVerify;
import com.base.auth.token.SysUserToken;
import com.base.auth.token.TokenStatus;
import com.base.auth.usercontext.SysCurrentUserContext;
import com.twshop.entity.admin.SysUser;
import com.twshop.service.admin.ISysUserService;

public class UserTokenVerify extends AbstractUserTokenVerify {

	private static final Logger LOGGER = LogManager.getLogger(UserTokenVerify.class);

	private ISysUserService sysUserService;

	public UserTokenVerify(ISysUserService sysUserService) {
		this.sysUserService = sysUserService;
	}

	@Override
	public TokenStatus verify(AbstractUserToken userToken, int[] userKind) {
		try {
			if (userToken == null) {
				return TokenStatus.FAIL;
			}
			SysUserToken userToken4Sys = (SysUserToken) userToken;
			Long sysUserId = userToken4Sys.getSysUserId();
			if (sysUserId == null) {
				return TokenStatus.FAIL;
			}
			// 1、read cache
			SysCurrentUserContext userContext = sysUserService.findSysCurrentUserFromCache(sysUserId);
			if (userContext != null) {
				if (!userContext.getUserPwd().equals(userToken4Sys.getSysUserPwd())) {
					return TokenStatus.FAIL;
				}
			} else {
				// 2、查数据库
				SysUser sysUser = sysUserService.getById(sysUserId);
				if (sysUser == null) {
					return TokenStatus.FAIL;
				}
				if (!sysUser.getUserPwd().equals(userToken4Sys.getSysUserPwd())) {
					return TokenStatus.FAIL;
				}

				// 3、set cache
				sysUserService.setSysCurrentUser2Cache(new SysCurrentUserContext((long) sysUser.getId().intValue(),
						(long) sysUser.getOrgId().intValue(), sysUser.getUserName(), sysUser.getUserPwd()));
			}
			return TokenStatus.SUCCESS;
		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		}
		return TokenStatus.FAIL;
	}

}
