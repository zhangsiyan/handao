<?php
/**
 * Created by PhpStorm.
 * User: taohs
 * Date: 8/13/15
 * Time: 22:30
 * @author taohaisong <taohaisong@gmail.com>
 * @date: 8/13/15  Time: 22:30
 * @link http://www.php4s.com/
 * @copyright
 * @license http://www.php4s.com/license/
 * @package PHP
 */

/**
 * Class SignController
 */
class SignController extends ControllerBase
{
    /**
     * 初始化
     *
     */
    public function initialize()
    {

        $this->tag->prependTitle("handao365");
        $this->view->setMainView('login');
        $this->view->setLayout('empty');
    }

    /**
     * PHP 5 allows developers to declare constructor methods for classes.
     * Classes which have a constructor method call this method on each newly-created object,
     * so it is suitable for any initialization that the object may need before it is used.
     *
     * Note: Parent constructors are not called implicitly if the child class defines a constructor.
     * In order to run a parent constructor, a call to parent::__construct() within the child constructor is required.
     *
     * param [ mixed $args [, $... ]]
     * @return void
     * @link http://php.net/manual/en/language.oop5.decon.php
     */
    function onConstruct()
    {
        // TODO: Implement __construct() method.
    }


    public function indexAction()
    {


        if ($this->request->isPost()) {

            if ($this->security->checkToken($this->session->get('$PHALCON/CSRF/KEY$'),$this->security->getSessionToken())) {//todo 这里需要使用if ($this->security->checkToken()) 因为未知原因导致失败
//            if ($this->security->checkToken()) {//todo 这里需要使用if ($this->security->checkToken()) 因为未知原因导致失败

                $username = $this->request->getPost('inputEmail', 'email');
                $password = $this->request->getPost('inputPassword', 'string');
                $admin = HdAdmin::findFirst(
                    array(
                        'conditions' => 'username=:username:',
                        'bind' => array(
                            'username' => $username,
                        )
                    ));
                if ($admin && $this->security->checkHash($password,$admin->password)) {
                    $this->session->set($this->config->session->loginKey, $admin);
                    $this->flash->success("success");
                    //change the password in the database with hash different from earlier
                    //This situation should use the observer pattern
                    //$admin->password = $this->security->hash($password);
                    //$admin->save();
                    return $this->response->redirect('admin/list');
                } else {
                    $this->flash->error("password errors");
                }
            } else {
                $this->flash->error("token errors");
            }
            return $this->refresh();
        }

    }




    /**
     *
     */
    public function outAction()
    {
        $this->session->remove($this->config->session->loginKey);
        $this->forceLogin();
    }

    public function validPassword($password = null)
    {
        if (is_null($password))
            throw new \Phalcon\Forms\Exception("password is null", E_USER_ERROR);
        return sha1($password);
    }

    public function changePassword($password = null, $salt = null)
    {

    }

    public function createAdminAction(){

        $time = date('Y-m-d H:i:s');
        $role = new HdAdminRole();
        $role->name = '终极管理员';
        $role->is_valid = 1;
        $role->create_time = $time;
        $role->update_time = $time;
        $role->create();
        $role->id;


        $admin = new HdAdmin();
        $admin->username = 'taohaisong@gmail.com';
        $admin->nickname = 'taohaisong';
        $admin->is_valid = 1;
        $admin->create_time = $time;
        $admin->update_time = $time;
        $admin->password = $this->security->hash($this->config->user->password->default);
        $admin->role = $role->id;
        $admin->create();


    }

}
