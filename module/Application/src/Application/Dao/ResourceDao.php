<?php
/**
 * Account Manager System (https://github.com/PsyduckMans/accountmanager)
 *
 * @link      https://github.com/PsyduckMans/accountmanager for the canonical source repository
 * @copyright Copyright (c) 2014 PsyduckMans (https://ninth.not-bad.org)
 * @license   https://github.com/PsyduckMans/accountmanager/blob/master/LICENSE MIT
 * @author    Psyduck.Mans
 */

namespace Application\Dao;

use Propel\Resource;

/**
 * Interface ResourceDao
 * @package Application\Dao
 */
interface ResourceDao {

    /**
     * @param $categoryId
     * @param array $page Ext direct page request
     * @return array(
     *      'total' => int
     *      'list' => \PropelObjectCollection
     * )
     */
    public function findByCategoryId($categoryId, array $page);

    /**
     * @param $id
     * @return \Propel\Resource|null
     */
    //public function getResourceById($id);

    /**
     * @param Resource $resource
     * @return int
     * @throws \Application\Dao\RuntimeException
     */
    //public function save(Resource $resource);
}