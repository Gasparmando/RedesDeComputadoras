'use strict';

/**
 * Hola.js controller
 *
 * @description: A set of functions called "actions" for managing `Hola`.
 */

module.exports = {

  /**
   * Retrieve hola records.
   *
   * @return {Object|Array}
   */

  find: async (ctx) => {
    return strapi.services.hola.fetchAll(ctx.query);
  },

  /**
   * Retrieve a hola record.
   *
   * @return {Object}
   */

  findOne: async (ctx) => {
    if (!ctx.params._id.match(/^[0-9a-fA-F]{24}$/)) {
      return ctx.notFound();
    }

    return strapi.services.hola.fetch(ctx.params);
  },

  /**
   * Count hola records.
   *
   * @return {Number}
   */

  count: async (ctx) => {
    return strapi.services.hola.count(ctx.query);
  },

  /**
   * Create a/an hola record.
   *
   * @return {Object}
   */

  create: async (ctx) => {
    return strapi.services.hola.add(ctx.request.body);
  },

  /**
   * Update a/an hola record.
   *
   * @return {Object}
   */

  update: async (ctx, next) => {
    return strapi.services.hola.edit(ctx.params, ctx.request.body) ;
  },

  /**
   * Destroy a/an hola record.
   *
   * @return {Object}
   */

  destroy: async (ctx, next) => {
    return strapi.services.hola.remove(ctx.params);
  }
};
