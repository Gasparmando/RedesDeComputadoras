'use strict';

/**
 * Inventariodeservidores.js controller
 *
 * @description: A set of functions called "actions" for managing `Inventariodeservidores`.
 */

module.exports = {

  /**
   * Retrieve inventariodeservidores records.
   *
   * @return {Object|Array}
   */

  find: async (ctx) => {
    return strapi.services.inventariodeservidores.fetchAll(ctx.query);
  },

  /**
   * Retrieve a inventariodeservidores record.
   *
   * @return {Object}
   */

  findOne: async (ctx) => {
    if (!ctx.params._id.match(/^[0-9a-fA-F]{24}$/)) {
      return ctx.notFound();
    }

    return strapi.services.inventariodeservidores.fetch(ctx.params);
  },

  /**
   * Count inventariodeservidores records.
   *
   * @return {Number}
   */

  count: async (ctx) => {
    return strapi.services.inventariodeservidores.count(ctx.query);
  },

  /**
   * Create a/an inventariodeservidores record.
   *
   * @return {Object}
   */

  create: async (ctx) => {
    return strapi.services.inventariodeservidores.add(ctx.request.body);
  },

  /**
   * Update a/an inventariodeservidores record.
   *
   * @return {Object}
   */

  update: async (ctx, next) => {
    return strapi.services.inventariodeservidores.edit(ctx.params, ctx.request.body) ;
  },

  /**
   * Destroy a/an inventariodeservidores record.
   *
   * @return {Object}
   */

  destroy: async (ctx, next) => {
    return strapi.services.inventariodeservidores.remove(ctx.params);
  }
};
