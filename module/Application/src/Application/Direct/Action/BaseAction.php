<?php
/**
 * Account Manager System (https://github.com/PsyduckMans/accountmanager)
 *
 * @link      https://github.com/PsyduckMans/accountmanager for the canonical source repository
 * @copyright Copyright (c) 2014 PsyduckMans (https://ninth.not-bad.org)
 * @license   https://github.com/PsyduckMans/accountmanager/blob/master/LICENSE MIT
 * @author    Psyduck.Mans
 */

namespace Application\Direct\Action;

use Zend\ServiceManager\ServiceManager;

/**
 * Class BaseAction
 * @package Application\Direct\Action
 */
class BaseAction {
    /**
     * @var ServiceManager
     */
    private $sm;

    /**
     * @var \Application\Auth\Identity
     */
    private $identity;

    /**
     * @var \DI\Container
     */
    protected $container;

    /**
     * __construct
     *
     * @param ServiceManager $sm
     */
    public function __construct(ServiceManager $sm) {
        // service manager
        $this->sm = $sm;

        // auth identity
        $this->identity = $this->getServiceManager()->get('Accountmanager\Auth\AuthenticationService')->getIdentity();

        // Inject dependencies
        if ($this->container == null) {
            $this->container = new \DI\Container();
        }
        $this->container->injectOn($this);
    }

    /**
     * @return ServiceManager
     */
    public function getServiceManager() {
        return $this->sm;
    }

    /**
     * @return bool
     */
    protected function hasIdentity() {
        return null !== $this->identity;
    }

    /**
     * @return \Application\Auth\Identity
     */
    protected function getIdentity() {
        return $this->identity;
    }
}