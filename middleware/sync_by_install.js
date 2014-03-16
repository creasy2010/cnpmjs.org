/*!
 * cnpmjs.org - middleware/sync_by_install.js
 *
 * Copyright(c) cnpmjs.org and other contributors.
 * MIT Licensed
 *
 * Authors:
 *  dead_horse <dead_horse@qq.com> (http://deadhorse.me)
 */

'use strict';

/**
 * Module dependencies.
 */

var debug = require('debug')('cnpmjs.org:middleware:sync_by_install');
var config = require('../config');

/**
 * req.session.allowSync  -  allow sync triggle by cnpm install
 */

module.exports = function *syncByInstall(next) {
  if (!config.syncByInstall || !config.enablePrivate) {
    // only config.enablePrivate should enable sync on install
    return yield *next;
  }
  // request not by node, consider it request from web
  if (this.get('user-agent') && this.get('user-agent').indexOf('node') !== 0) {
    return yield *next;
  }

  if (this.query.write) {
    return yield *next;
  }

  this.allowSync = true;
  yield *next;
};
