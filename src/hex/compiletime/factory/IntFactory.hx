package hex.compiletime.factory;

#if macro
import haxe.macro.*;

/**
 * ...
 * @author Francis Bourre
 */
class IntFactory
{
	/** @private */ function new() throw new hex.error.PrivateConstructorException();
	
	static public function build<T:hex.compiletime.basic.vo.FactoryVOTypeDef>( factoryVO : T ) : Expr
	{
		var result 	: Int 		= 0;
		var constructorVO 		= factoryVO.constructorVO;
		var idVar 				= constructorVO.ID;
		var args 				= constructorVO.arguments;

		if ( args != null && args.length > 0 ) 
		{
			var s = Std.string( args[ 0 ] );
			result = Std.parseInt( s );
		}
		else
		{
			Context.error( "Invalid arguments: " + constructorVO, constructorVO.filePosition );
		}
		
		//Building result
		return constructorVO.shouldAssign ?
			macro @:pos( constructorVO.filePosition ) var $idVar = $v{ result }:
			macro @:pos( constructorVO.filePosition ) $v{ result };	
	}
}
#end